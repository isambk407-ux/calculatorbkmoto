-- صندوق المحل — قاعدة البيانات
-- انسخ هاد الملف كامل فـ Supabase → SQL Editor → New query → Run

create table if not exists public.entries (
  id          uuid primary key default gen_random_uuid(),
  type        text not null check (type in ('sale','advance','expense','withdrawal','deposit')),
  date        date not null,
  amount      numeric(14,2) not null check (amount > 0),
  method      text not null default 'cash' check (method in ('cash','transfer','cheque')),
  label       text,
  category    text,
  client      text,
  note        text,
  kept        numeric(14,2),
  example     boolean not null default false,
  created_at  timestamptz not null default now(),
  created_by  uuid default auth.uid()
);

create index if not exists entries_date_idx on public.entries (date);

-- الحماية: غير اللي مسجلين الدخول (نتا والموظف) يقدرو يشوفو ويكتبو
alter table public.entries enable row level security;

drop policy if exists "read for signed-in"   on public.entries;
drop policy if exists "insert for signed-in" on public.entries;
drop policy if exists "update for signed-in" on public.entries;
drop policy if exists "delete for signed-in" on public.entries;

create policy "read for signed-in"   on public.entries for select to authenticated using (true);
create policy "insert for signed-in" on public.entries for insert to authenticated with check (true);
create policy "update for signed-in" on public.entries for update to authenticated using (true) with check (true);
create policy "delete for signed-in" on public.entries for delete to authenticated using (true);

-- التحديث المباشر: إلا دخل الموظف عملية، كتبان عندك فالحين
do $$ begin
  alter publication supabase_realtime add table public.entries;
exception when duplicate_object then null; end $$;
