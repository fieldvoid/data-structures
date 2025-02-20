import doublyLinkedList;

struct Queue (T) {
    DoublyLinkedList!T list;

    int length () => list.length;

    void enqueue (T data) {
        list.push(data);
    }

    T dequeue () {
        return list.deAppend;
    }

    void print () {
        list.print;
    }
}
