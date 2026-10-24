def step(q, mode, p, si, en=True):
    if not en:
        return q
    if mode == 0:       # HOLD
        return q
    if mode == 1:       # LOAD
        return p & 0xff
    if mode == 2:       # LEFT
        return ((q << 1) & 0xff) | (si & 1)
    if mode == 3:       # RIGHT
        return ((q >> 1) & 0x7f) | ((si & 1) << 7)
    raise ValueError(mode)

def serial_out(q, mode):
    if mode == 2:
        return (q >> 7) & 1
    if mode == 3:
        return q & 1
    return 0

def run():
    q = 0
    assert step(q,0,0xAA,1) == 0
    q = step(q,1,0xA5,0)
    assert q == 0xA5
    assert step(q,2,0,1) == 0x4B
    assert step(q,2,0,0) == 0x4A
    assert step(q,3,0,1) == 0xD2
    assert step(q,3,0,0) == 0x52
    assert step(q,1,0x3C,0,False) == 0xA5

    # Exhaustive q/mode/serial checks.
    for q in range(256):
        for si in (0,1):
            assert step(q,2,0,si) == (((q << 1) & 0xff) | si)
            assert step(q,3,0,si) == (((q >> 1) & 0x7f) | (si << 7))
    print("E01 reference model PASS")

if __name__ == "__main__":
    run()
