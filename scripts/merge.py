import pya, os
tech = pya.Technology(); tech.load(os.environ["LYT"])
opt = tech.load_layout_options
cfg = opt.lefdef_config
cfg.read_lef_with_def = False
cfg.lef_files = [os.environ["LEF"]]
opt.lefdef_config = cfg
ly = pya.Layout(); ly.read(os.environ["DEFF"], opt)
paths = {os.path.basename(l.strip())[:-4]: l.strip() for l in open("cell_gds.list") if l.strip()}
done, missing = 0, []
for c in list(ly.each_cell()):
    if not c.name.startswith("sky130_fd_sc_hd__"): continue
    p = paths.get(c.name)
    if not p: missing.append(c.name); continue
    src = pya.Layout(); src.read(p)
    sc = src.cell(c.name)
    if sc is None: missing.append(c.name); continue
    c.clear(); c.copy_tree(sc); done += 1
print("dbu:", ly.dbu, "| cells replaced:", done, "| missing:", missing)
top = ly.top_cell()
want = {(65,20):"diff",(66,20):"poly",(64,20):"nwell",(66,44):"licon",(93,44):"nsdm",(94,20):"psdm"}
have = {(i.layer,i.datatype) for i in ly.layer_infos() if not top.bbox_per_layer(ly.layer(i)).empty()}
for k,v in want.items(): print(v, k, "PRESENT" if k in have else "MISSING")
print("BBOX um:", top.dbbox())
ly.write("eventpilot.gds"); print("WROTE eventpilot.gds")
