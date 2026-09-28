-- Fredagens lille avstemning 🗳️
-- Run this in Supabase SQL Editor.

create table if not exists public.weekend_votes (
  poll_id text primary key,
  answer text not null check (answer in ('yes','no')),
  updated_at timestamptz not null default now()
);

alter table public.weekend_votes enable row level security;

revoke all on table public.weekend_votes from anon, authenticated;
grant select, insert, update on table public.weekend_votes to anon;

drop policy if exists "Public can read weekend votes" on public.weekend_votes;
create policy "Public can read weekend votes"
on public.weekend_votes
for select
to anon
using (true);

drop policy if exists "Public can submit weekend vote" on public.weekend_votes;
create policy "Public can submit weekend vote"
on public.weekend_votes
for insert
to anon
with check (answer in ('yes','no'));

drop policy if exists "Public can update weekend vote" on public.weekend_votes;
create policy "Public can update weekend vote"
on public.weekend_votes
for update
to anon
using (true)
with check (answer in ('yes','no'));

-- The host's reset button uses DELETE. For a simple private two-person poll,
-- allow delete only for the single poll row.
grant delete on table public.weekend_votes to anon;

drop policy if exists "Public can reset weekend vote" on public.weekend_votes;
create policy "Public can reset weekend vote"
on public.weekend_votes
for delete
to anon
using (poll_id = 'fredag');
