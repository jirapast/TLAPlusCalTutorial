https://marabos.nl/atomics/hardware.html#:~:text=example%20demonstrates%20that%3A-,Rust%20source,-Compiled%20x86%2D64

pub fn a(x: &mut i32) {
    *x += 10;
}

a:
    add dword ptr [rdi], 10
    ret
