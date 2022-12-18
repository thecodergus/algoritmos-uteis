struct Node<T> {
    data: T,
    next: Option<Box<Node<T>>>,
    prev: Option<Box<Node<T>>>,
}

impl<T> Node<T> {
    fn new(data: T) -> Self {
        Self {
            data,
            next: None,
            prev: None,
        }
    }
}

struct DoublyLinkedList<T> {
    head: Option<Box<Node<T>>>,
    tail: Option<Box<Node<T>>>,
}

impl<T> DoublyLinkedList<T> {
    fn new() -> Self {
        Self { head: None, tail: None }
    }

    fn push_front(&mut self, data: T) {
        let new_node = Box::new(Node::new(data));
        match self.head.take() {
            Some(old_head) => {
                old_head.prev = Some(new_node.clone());
                new_node.next = Some(old_head);
                self.head = Some(new_node);
            }
            None => {
                self.tail = Some(new_node.clone());
                self.head = Some(new_node);
            }
        }
    }

    fn push_back(&mut self, data: T) {
        let new_node = Box::new(Node::new(data));
        match self.tail.take() {
            Some(old_tail) => {
                old_tail.next = Some(new_node.clone());
                new_node.prev = Some(old_tail);
                self.tail = Some(new_node);
            }
            None => {
                self.head = Some(new_node.clone());
                self.tail = Some(new_node);
            }
        }
    }

    fn pop_front(&mut self) -> Option<T> {
        self.head.take().map(|old_head| {
            match old_head.next.take() {
                Some(new_head) => {
                    new_head.prev = None;
                    self.head = Some(new_head);
                }
                None => {
                    self.tail = None;
                }
            }
            old_head.data
        })
    }

    fn pop_back(&mut self) -> Option<T> {
        self.tail.take().map(|old_tail| {
            match old_tail.prev.take() {
                Some(new_tail) => {
                    new_tail.next = None;
                    self.tail = Some(new_tail);
                }
                None => {
                    self.head = None;
                }
            }
            old_tail.data
        })
    }
}
