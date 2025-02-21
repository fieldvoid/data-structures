module alloc;

import core.stdc.stdlib;

auto alloc (T, A...) (A args) {
    import core.lifetime;

    static if (is(T == class)) {
        T _obj = cast(T) malloc(__traits(classInstanceSize, T));
        T obj = _obj.emplace(args);
    }
    else {
        T* _obj = cast(T) malloc(T.sizeof);
        T* obj = _obj.emplace(args);
    }

    return obj;
}

unittest {
    class A {
        class B {
            string str;

            this (string str) {
                this.str = str;
            }
        }

        B obj;
        int x;

        this (int x) {
            this.x = x;
            obj = alloc!B(this, "abc");
        }
    }
}

unittest {
    auto a = alloc!A(123);
    import std.stdio;

    a.obj.str.writeln;
    writeln(a.obj.outer is a);
    writeln(a.obj.outer);

    free(cast(void*) a.obj);
    free(cast(void*) a);
}
