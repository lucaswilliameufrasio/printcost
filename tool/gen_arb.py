"""Generates lib/l10n/app_pt.arb and app_en.arb from tool/strings*.py."""
import glob, importlib.util, json, os

root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
strings = {}
for path in sorted(glob.glob(os.path.join(root, 'tool', 'strings*.py'))):
    spec = importlib.util.spec_from_file_location(os.path.basename(path)[:-3], path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    for k in mod.S:
        if k in strings:
            raise SystemExit(f'duplicate key {k}')
    strings.update(mod.S)

for idx, lang in ((0, 'pt'), (1, 'en')):
    out = {'@@locale': lang}
    for key, v in strings.items():
        out[key] = v[idx]
        if lang == 'pt' and len(v) > 2:
            out['@' + key] = {'placeholders': {p: {'type': t} for p, t in v[2].items()}}
    with open(os.path.join(root, 'lib', 'l10n', f'app_{lang}.arb'), 'w', encoding='utf-8') as f:
        json.dump(out, f, ensure_ascii=False, indent=2)
        f.write('\n')
print(f'{len(strings)} strings')
