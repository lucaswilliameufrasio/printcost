"""Builds the sample .3mf files used by test/data/three_mf_parser_test.dart.

They mimic what Bambu Studio writes (Metadata/slice_info.config). They are
synthetic: validate the parser with a real file too (see README).
Run: python3 tool/make_3mf_fixtures.py
"""
import os, zipfile

root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
out = os.path.join(root, 'test', 'fixtures')
os.makedirs(out, exist_ok=True)

CONTENT_TYPES = '''<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
 <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
 <Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/>
 <Default Extension="png" ContentType="image/png"/>
 <Default Extension="gcode" ContentType="text/x.gcode"/>
</Types>
'''
MODEL = '''<?xml version="1.0" encoding="UTF-8"?>
<model unit="millimeter" xml:lang="en-US" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">
 <metadata name="Application">BambuStudio-01.10.01.50</metadata>
 <resources/>
 <build/>
</model>
'''
SLICE_INFO = '''<?xml version="1.0" encoding="UTF-8"?>
<config>
  <header>
    <header_item key="X-BBL-Client-Type" value="slicer"/>
    <header_item key="X-BBL-Client-Version" value="01.10.01.50"/>
  </header>
  <plate>
    <metadata key="index" value="1"/>
    <metadata key="printer_model_id" value="N2S"/>
    <metadata key="nozzle_diameters" value="0.4"/>
    <metadata key="timelapse_type" value="0"/>
    <metadata key="prediction" value="8122"/>
    <metadata key="weight" value="45.31"/>
    <metadata key="outside" value="false"/>
    <metadata key="support_used" value="false"/>
    <metadata key="label_object_enabled" value="true"/>
    <object identify_id="196" name="Vaso.stl" skipped="false" />
    <filament id="1" tray_info_idx="GFA00" type="PLA" color="#FFFFFF" used_m="12.03" used_g="35.88" />
    <filament id="3" tray_info_idx="GFA00" type="PLA" color="#000000FF" used_m="3.16" used_g="9.43" />
    <warning msg="bed_temperature_too_high_than_filament" level="1" error_code ="1000C001"  />
  </plate>
  <plate>
    <metadata key="index" value="2"/>
    <metadata key="prediction" value="1500"/>
    <metadata key="weight" value="4.2"/>
    <object identify_id="320" name="Chaveiro.stl" skipped="false" />
    <filament id="2" tray_info_idx="GFG00" type="PETG" color="#1E88E5" used_m="1.4" used_g="4.2" />
  </plate>
  <plate>
    <metadata key="index" value="3"/>
    <metadata key="prediction" value="0"/>
    <metadata key="weight" value="0"/>
  </plate>
</config>
'''
MODEL_SETTINGS = '''<?xml version="1.0" encoding="UTF-8"?>
<config>
  <plate>
    <metadata key="plater_id" value="1"/>
    <metadata key="plater_name" value="Vaso bicolor"/>
    <metadata key="locked" value="false"/>
  </plate>
  <plate>
    <metadata key="plater_id" value="2"/>
    <metadata key="plater_name" value=""/>
  </plate>
</config>
'''
# Plate with only total weight (older files) and no per-filament used_g.
SLICE_INFO_NO_FILAMENT_WEIGHT = '''<?xml version="1.0" encoding="UTF-8"?>
<config>
  <plate>
    <metadata key="index" value="1"/>
    <metadata key="weight" value="20.5"/>
    <filament id="1" type="PLA" color="#FF0000" used_m="6.8"/>
  </plate>
</config>
'''

def write(name, files):
    with zipfile.ZipFile(os.path.join(out, name), 'w', zipfile.ZIP_DEFLATED) as z:
        for path, data in files.items():
            z.writestr(path, data)

base = {'[Content_Types].xml': CONTENT_TYPES, '3D/3dmodel.model': MODEL}
write('sample_bambu_sliced.3mf', {**base,
    'Metadata/slice_info.config': SLICE_INFO,
    'Metadata/model_settings.config': MODEL_SETTINGS,
    'Metadata/plate_1.gcode': '; HEADER_BLOCK_START\n',
})
write('sample_unsliced.3mf', dict(base))
write('sample_total_weight_only.3mf', {**base,
    'Metadata/slice_info.config': SLICE_INFO_NO_FILAMENT_WEIGHT,
})
write('not_a_3mf.zip', {'readme.txt': 'hello'})
print('ok')
