import pya, os
tech = pya.Technology()
tech.load(os.environ["LYT"])
opt = tech.load_layout_options
cfg = opt.lefdef_config; cfg.read_lef_with_def = False; print("tech lef_files before:", list(cfg.lef_files))
cfg.lef_files = [os.environ["LEF"]]
cfg.macro_layout_files = [l.strip() for l in open("cell_gds.list") if l.strip()]
opt.lefdef_config = cfg
ly = pya.Layout()
ly.read(os.environ["DEFF"], opt)
top = ly.top_cell()
print("TOP:", top.name, "| DEF components:", os.environ["NCOMP"])
print("top instances:", top.child_instances(), "| unique cells:", ly.cells())
empty = [c.name for c in ly.each_cell() if c.name.startswith("sky130_fd_sc_hd__") and c.bbox().empty()]
print("std cells with NO geometry:", len(empty), empty[:5])
print("BBOX um:", top.dbbox())
print("layers with shapes:", sorted({(i.layer, i.datatype) for i in ly.layer_infos() if not top.bbox_per_layer(ly.layer(i)).empty()}))
ly.write("eventpilot.gds")
print("WROTE eventpilot.gds")
