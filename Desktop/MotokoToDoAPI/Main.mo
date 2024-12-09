import Array "mo:base/Array";

actor TodoApp {
    type Task = {
        id: Nat;
        name: Text;
        completed: Bool;
    };

    var tasks : [Task] = [];  // Array yerine doğrudan liste kullanıyoruz

    // Yeni görev ekleme fonksiyonu
    public func addTask(name: Text) : async Task {
        let id = tasks.size();  // Yeni görev için benzersiz ID
        let newTask : Task = { id = id; name = name; completed = false };
        tasks := Array.append(tasks, [newTask]);  // Yeni görevi ekliyoruz
        return newTask;
    };

    // Tüm görevleri getirme fonksiyonu
    public func getTasks() : async [Task] {
        return tasks;
    };

    // Bir görevi tamamlamak için fonksiyon
    public func completeTask(id: Nat) : async ?Task {
        let taskOpt = Array.find<Task>(tasks, func(t : Task) : Bool { t.id == id });

        switch (taskOpt) {
            case (?task) {
                // Görevi tamamlıyoruz
                let updatedTask : Task = { task with completed = true };
                tasks := Array.map<Task, Task>(tasks, func(t : Task) : Task {
                    if (t.id == id) { updatedTask } else { t }
                });
                return ?updatedTask;
            };
            case (_) { return null };  // Görev bulunamazsa null dönüyor
        };
    };
};
