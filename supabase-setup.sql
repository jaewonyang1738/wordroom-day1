create table if not exists public.word_progress (
  device_id text not null,
  day_number integer not null,
  word_index integer not null,
  status text not null default '',
  updated_at timestamptz not null default now(),
  primary key (device_id, day_number, word_index),
  constraint word_progress_status_check check (status in ('', 'done', 'review', 'miss'))
);

alter table public.word_progress enable row level security;

drop policy if exists "wordroom device progress" on public.word_progress;
create policy "wordroom device progress" on public.word_progress
for all to anon
using (true)
with check (true);

create index if not exists word_progress_device_day_idx
on public.word_progress (device_id, day_number);
