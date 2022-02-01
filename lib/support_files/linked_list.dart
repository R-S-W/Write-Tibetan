/* Simple linked list implementation, used in AppBrain class, namely for
  textHistory.
*/


class Node<E>{
  E value;
  Node next;
  Node prev;
  Node([E this.value, Node this.next, Node this.prev]);
}


class LinkedList<E> {
  Node head;
  Node tail;

  LinkedList(){
    this.head = Node();
    this.tail = Node();
    this.head.next = this.tail;
    this.tail.prev = this.head;
  }

  void addFirst(E value){
    Node n = Node(value);
    Node nNext = this.head.next;
    this.head.next = n;
    n.prev = this.head;
    n.next = nNext;
    nNext.prev = n;
  }

  void addLast(E value){
    Node n = Node(value);
    Node nPrev = this.tail.prev;
    this.tail.prev = n;
    n.next = this.tail;
    nPrev.next = n;
    n.prev = nPrev;
  }

  E removeFirst(){
    if (this.head.next != this.tail){
      Node n = this.head.next;
      Node nNext = n.next;
      this.head.next = nNext;
      nNext.prev = this.head;
      n.prev = null;
      n.next = null;
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


  LinkedListIterator(LinkedList<E> this.list){
    this.listHead = this.list.head;
    this.listTail = this.list.tail;
    this.current = (this.listHead != this.listTail) ? this.listHead.next : null;
  }

  bool goToStart(){
    if (this.listHead != this.listTail){
      this.current = this.listHead.next;
      return true;
    }
    return false;
  }


  bool goToFinish(){
    if (this.listHead !=this.listTail){
      this.current = this.listTail.prev;
      return true;
    }
    return false;
  }


  bool advance(){
    if (this.current != null){
      this.current = this.current.next;
      if (this.current == this.listTail){
        this.current = null;
      }
    }
    return this.current != null;
  }


  bool retreat(){
    if (this.current !=null){
      this.current = this.current.prev;
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
      return true;
    }
    return false;
  }


}