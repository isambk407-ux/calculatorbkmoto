# صندوق المحل

برنامج بسيط لتتبع أموال محل الدراجات النارية: المبيعات، التسبيقات (avances)، المصاريف، السحوبات من la caisse، وصفحة تحليلات فيها الكابيتال الكامل.

- الواجهة: صفحة HTML واحدة كتخدم على **GitHub Pages**
- البيانات: **Supabase** (free plan)
- الحماية: تسجيل الدخول بالبريد وكلمة السر، وما حد يقدر يشوف الأرقام بلا ما يدخل

## الملفات

| الملف | شنو فيه |
|---|---|
| `index.html` | البرنامج كامل |
| `config.js` | عنوان ومفتاح مشروع Supabase (خاصك تعمرو) |
| `schema.sql` | الجدول وقواعد الحماية ديال قاعدة البيانات |

## التنصيب (مرة وحدة)

### 1. Supabase
1. دخل لـ [supabase.com](https://supabase.com) وصاوب **New project** (free plan).
2. من القائمة: **SQL Editor → New query**، كوبي محتوى `schema.sql` كامل، ودير **Run**.
3. **Authentication → Users → Add user → Create new user**: صاوب حساب ليك وحساب للموظف (بريد + كلمة سر). علّم على **Auto Confirm User**.
4. **Authentication → Sign In / Providers**: سد **Allow new users to sign up** باش ما يقدر حتى واحد آخر يصاوب حساب.
5. **Project Settings → API**: خود **Project URL** و **anon public key**.

### 2. config.js
حل `config.js` وبدّل `XXXX` بالقيم اللي خديتي:

```js
window.CAISSE_CONFIG = {
  SUPABASE_URL: "https://abcdefgh.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOi..."
};
```

مفتاح **anon** عادي يكون ظاهر. أما مفتاح **service_role** ما تحطو أبداً فهاد الملف.

### 3. GitHub Pages
1. صاوب repository جديد فـ GitHub (`calculatorbkmoto`) وطلّع فيه الملفات التلاتة.
2. **Settings → Pages → Build and deployment**: اختار **Deploy from a branch**، الـ branch `main`، والمجلد `/ (root)`، ودير **Save**.
3. من بعد دقيقة ولا جوج، البرنامج غادي يكون على:
   `https://isambk407-ux.github.io/calculatorbkmoto/`

## كيفاش كيتحسب الصندوق

- **في الصندوق** = المداخيل نقداً (cash) + الإيداعات − المصاريف المدفوعة نقداً − السحوبات
- المبيعات بالـ virement ولا الشيك ما كتدخلش للصندوق، كتتحسب «عبر البنك»
- **الكابيتال الكامل** = في الصندوق + عبر البنك + مجموع اللي سحبتي
- فاش كتسحب، تقدر تكتب المبلغ اللي كتسحب، ولا المبلغ اللي بغيتي يبقى فالصندوق (مثلاً 1000 DH) والبرنامج كيحسب الباقي

## Free plan ديال Supabase

المشروع المجاني كيتوقف (pause) إلا بقا 7 أيام بلا ما يتستعمل. إلا كتستعمل البرنامج كل نهار، ما كاين مشكل. وإلا توقف، دخل لـ Supabase ودير **Restore**، والبيانات كتبقى محفوظة.

نصيحة: صدّر السجل لـ Excel (زر «تصدير CSV» فصفحة السجل) مرة فالشهر كنسخة احتياطية.
