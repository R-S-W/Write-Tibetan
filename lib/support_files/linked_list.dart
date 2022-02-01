/* Simple linked list implementation, used in AppBrain class, namely for
  textHistory.
*/


class Node<E>{
  E value;
  Node next;
  Node prev;
  Node([this.value, this.next, this.prev]);
}


class LinkedList<E> {
  Node head;
  Node tail;
  int length = 0;

  LinkedList(){
    this.head = Node();
    this.tail = Node();
    this.head.next = this.tail;
    this.tail.prev = this.head;
  }


  E get first => (this.length != 0) ? this.head.next.value : null;

  E get last => (this.length != 0) ? this.tail.prev.value : null;



  void addFirst(E value){
    Node n = Node(value);
    Node nNext = this.head.next;
    this.head.next = n;
    n.prev = this.head;
    n.next = nNext;
    nNext.prev = n;
    this.length += 1;
  }

  void addLast(E value){
    Node n = Node(value);
    Node nPrev = this.tail.prev;
    this.tail.prev = n;
    n.next = this.tail;
    nPrev.next = n;
    n.prev = nPrev;
    this.length += 1;
  }

  E removeFirst(){
    if (this.head.next != this.tail){
      Node n = this.head.next;
      Node nNext = n.next;
      this.head.next = nNext;
      nNext.prev = this.head;
      n.prev = null;
      n.next = null;
      this.length -= 1;
      return n.value;
    }
    return null;
  }

  E removeLast(){
    if (this.head != this.tail.prev){
      Node n = this.tail.prev;
      Node nPrev = n.prev;
      this.tail.prev = nPrev;
      nPrev.next = this.tail;
      n.next = null;
      n.prev = null;
      this.length -= 1;
      return n.value;
    }
    return null;
  }

}

class LinkedListIterator<E>{
  LinkedList<E> list;
  Node<E> listHead;
  Node<E> listTail;
  Node<E> current;
  int index = -1;


  LinkedListIterator(this.list){
    this.listHead = this.list.head;
    this.listTail = this.list.tail;
    this.current = (this.listHead != this.listTail) ? this.listHead.next : null;
  }


  bool get isEmpty{
    return this.listHead == this.listTail;
  }

  bool goToStart(){
    if (!isEmpty){
      this.current = this.listHead.next;
      index = 0;
      return true;
    }
    return false;
  }


  bool goToFinish(){
    if (!isEmpty){
      this.current = this.listTail.prev;
      index = this.list.length;
      return true;
    }
    return false;
  }


  bool advance(){
    if (this.current != null){
      this.current = this.current.next;
      this.index += 1;
      if (this.current == this.listTail){
        this.current = null;
        this.index = -1;
      }
    }
    return this.current != null;
  }


  bool retreat(){
    if (this.current !=null){
      this.current = this.current.prev;
      this.index -= 1;
      if (this.current == this.listHead){
        this.current = null;
      }
    }
    return this.current != null;
  }


  bool removeAfterCurrent(){
    if (this.current != null && this.current.next != this.listTail){
      Node cNext = current.next;
      Node tPrev = this.listTail.prev;
      this.current.next = this.listTail;
      this.listTail.prev = this.current;
      cNext.prev = null;
      tPrev.next = null;
      this.list.length = this.index +1;
      return true;
    }
    return false;
  }


}