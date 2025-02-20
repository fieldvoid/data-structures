module doublyLinkedList;

class ListUnderflow: Exception {
    this (T...) (T args) {
        super(args);
    }
}

struct DoublyLinkedList (T) {
    static struct Node {
        T data;
        Node*[2] links;
    }

    Node* first, last;
    private int length_;

    int length () => length_;

    void push (T data) {
        if (length_ < 1) {
            first = new Node(data);
            last = first;
        }
        else {
            auto temp = new Node(data, [null, first]);
            first.links[0] = temp;
            first = temp;
        }
        ++length_;
    }

    void append (T data) {
        if (length_ < 1) {
            first = new Node(data);
            last = first;
        }
        else {
            auto temp = new Node(data, [last, null]);
            last.links[1] = temp;
            last = temp;
        }
        ++length_;
    }

    T pop () {
        if (length_ < 1) {
            throw new ListUnderflow("");
        }

        auto data = first.data;

        if (length_ == 1) {
            first = null;
            last = null;
        }
        else {
            first = first.links[1];
            first.links[0] = null;
        }

        --length_;

        return data;
    }

    T deAppend () {
        if (length_ < 1) {
            throw new ListUnderflow("");
        }

        auto data = last.data;

        if (length_ == 1) {
            first = null;
            last = null;
        }
        else {
            last = last.links[0];
            last.links[1] = null;
        }

        --length_;

        return data;
    }

    void print () {
        import std.stdio;
        if (length_ < 1) {
            writeln("()");
            return;
        }

        write("(");

        Node* walker = first;
        foreach (i; 0..length_-1) {
            if (walker !is null) {
                writef!"%s "(walker.data);
                walker = walker.links[1];
            }
        }
        if (walker !is null) {
            writef!"%s"(walker.data);
        }

        writeln(")");
    }
}

unittest {
    import std.stdio;

    DoublyLinkedList!int list;
    list.length.writeln;

    list.print;

    list.push(1);
    list.push(2);
    list.push(3);
    list.push(4);
    list.print;

    list.append(5);
    list.append(6);
    list.print;

    list.pop;
    list.pop;
    list.deAppend;
    list.print;
}
