import xml.etree.ElementTree as ET, collections
r = ET.parse("eventpilot_drc.lyrdb").getroot()
c = collections.Counter((i.findtext("category") or "?").strip("'") for i in r.iter("item"))
print("TOTAL violations:", sum(c.values()))
for k, v in c.most_common(15): print(f"{v:6d}  {k}")
