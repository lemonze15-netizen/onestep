create extension if not exists pgcrypto;
create table if not exists public.goals (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 title text not null check (char_length(title) between 3 and 140),
 goal_data jsonb not null default '{}'::jsonb,
 plan jsonb not null,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
alter table public.goals enable row level security;
drop policy if exists "read own goals" on public.goals;
create policy "read own goals" on public.goals for select to authenticated using (auth.uid() = user_id);
drop policy if exists "create own goals" on public.goals;
create policy "create own goals" on public.goals for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "update own goals" on public.goals;
create policy "update own goals" on public.goals for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "delete own goals" on public.goals;
create policy "delete own goals" on public.goals for delete to authenticated using (auth.uid() = user_id);
create or replace function public.touch_updated_at() returns trigger language plpgsql as $$ begin new.updated_at = now(); return new; end; $$;
drop trigger if exists goals_touch_updated_at on public.goals;
create trigger goals_touch_updated_at before update on public.goals for each row execute function public.touch_updated_at();

