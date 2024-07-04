use magnus::{define_module, class, function, method, prelude::*, Error};

fn hexdigest(subject: String) -> String {
    let hash = blake3::hash(subject.as_bytes());
    return hash.to_string();
}

fn derive_key(context: String, key: String) -> String {
    let key = blake3::derive_key(context.as_str(), key.as_bytes());
    hex::encode(key)
}

#[derive(Clone)]
struct Hasher {
    hasher: blake3::Hasher,
}

#[magnus::wrap(class = "Digest::Blake3::Hasher")]
struct MutHasher(std::cell::RefCell<Hasher>);

impl MutHasher {
    fn new() -> Self {
        let blake_hasher = blake3::Hasher::new();
        let hasher = Hasher { hasher: blake_hasher };
        let ref_hasher = std::cell::RefCell::new(hasher);
        Self(ref_hasher)
    }

    fn update(&self, subject: String) -> Self {
        self.0.borrow_mut().hasher.update(subject.as_bytes());
        return Self(self.0.clone());
    }

    fn finalize(&self) -> String {
        let hash = self.0.borrow().hasher.finalize();
        return hash.to_string();
    }
}

#[magnus::init]
fn init() -> Result<(), Error> {
    let digest = define_module("Digest")?;
    let blake3 = digest.define_module("Blake3")?;
    
    blake3.define_singleton_method("hexdigest", function!(hexdigest, 1))?;
    blake3.define_singleton_method("derive_key", function!(derive_key, 2))?;

    let class = blake3.define_class("Hasher", class::object())?;
    class.define_singleton_method("new", function!(MutHasher::new, 0))?;
    class.define_method("update", method!(MutHasher::update, 1))?;
    class.define_method("finalize", method!(MutHasher::finalize, 0))?;

    Ok(())
}
