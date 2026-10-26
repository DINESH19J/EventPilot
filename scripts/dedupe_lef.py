import re, sys
src, dst = sys.argv[1], sys.argv[2]
seen, out, skip, dups = set(), [], None, []
pat = re.compile(r'^(MACRO|VIA|SITE|LAYER)\s+(\S+)\s*$')
for line in open(src):
    if skip:
        if re.match(r'^END\s+%s\s*$' % re.escape(skip[1]), line): skip = None
        continue
    m = pat.match(line)
    if m:
        key = (m.group(1), m.group(2))
        if key in seen:
            skip = key; dups.append(key); continue
        seen.add(key)
    out.append(line)
open(dst, 'w').writelines(out)
print("duplicate blocks removed:", len(dups), dups[:5])
print("macros kept:", sum(1 for k in seen if k[0]=='MACRO'), "| layers:", sum(1 for k in seen if k[0]=='LAYER'))
