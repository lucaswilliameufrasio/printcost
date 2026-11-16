"""Choose a connected mobile device before starting Flutter."""

import json
import os
import subprocess
import sys


def main():
    flutter = sys.argv[1]
    arguments = sys.argv[2:]
    device_id = os.environ.get("DEVICE", "")

    if not device_id:
        try:
            result = subprocess.run(
                [flutter, "devices", "--machine"],
                check=True,
                capture_output=True,
                text=True,
            )
            devices = json.loads(result.stdout)
        except (OSError, subprocess.CalledProcessError, json.JSONDecodeError) as error:
            print(f"Não foi possível listar os dispositivos: {error}", file=sys.stderr)
            return 1

        mobile_devices = [
            device
            for device in devices
            if device.get("isSupported")
            and device.get("targetPlatform", "").split("-")[0] in ("android", "ios")
        ]
        if not mobile_devices:
            print("Nenhum dispositivo Android ou iOS disponível.")
            print("Conecte um aparelho ou inicie um emulador e tente novamente.")
            return 1

        print("\nOnde você quer executar o PrintCost?")
        for index, device in enumerate(mobile_devices, start=1):
            kind = "Emulador" if device.get("emulator") else "Dispositivo"
            print(f"  {index}) {device['name']} — {kind} ({device['id']})")
        print("  0) Cancelar")

        while True:
            try:
                choice = input("\nEscolha uma opção: ").strip()
            except (EOFError, KeyboardInterrupt):
                print("\nOperação cancelada.")
                return 1
            if choice == "0":
                print("Operação cancelada.")
                return 0
            if choice.isdecimal() and 1 <= int(choice) <= len(mobile_devices):
                device_id = mobile_devices[int(choice) - 1]["id"]
                break
            print("Opção inválida. Escolha um número da lista.")

    try:
        os.execvp(flutter, [flutter, "run", "-d", device_id, *arguments])
    except OSError as error:
        print(f"Não foi possível iniciar o Flutter: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
