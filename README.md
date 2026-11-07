# OneStep Demo

繁體中文、手機優先的目標管理 demo。輸入目標後，Supabase Edge Function 以 GPT 產生結構化路線圖；目標與勾選進度只留在目前頁面記憶體，重新整理後清空，不寫入資料表。

## 本機啟動

需要 Node.js 20+、npm、Supabase CLI。

```bash
npm install
Copy-Item .env.example .env.local
# 編輯 .env.local，填入 Supabase Project URL 與 publishable/anon key
npm run dev
```

## Supabase 設定

在你的 Supabase 專案執行：

```bash
supabase login
supabase link --project-ref YOUR_PROJECT_REF
supabase db push
supabase secrets set OPENAI_API_KEY="你的 OpenAI API key"
supabase secrets set OPENAI_MODEL="gpt-4.1-mini"
supabase functions deploy goal-ai
```

`OPENAI_API_KEY` 值只放在 Supabase Edge Function Secrets，絕不可放入前端、聊天或 GitHub。Supabase Auth 的 Anonymous Sign-ins 必須啟用，讓前端取得呼叫 Edge Function 所需的 session；demo 不會寫入使用者目標資料。資料表與 RLS migration 已備好，但目前 demo 不使用持久化目標。

## 使用流程

輸入目標、原因、期限、每日時間及阻礙，按「分析並預覽計畫」。GPT 呼叫失敗會顯示錯誤，不使用假資料。按「使用這份計畫」後目標只加入目前頁面狀態；可勾 checklist，再按「AI 依進度重新規劃」，預覽確認後套用。重新整理或關閉頁面後，目標和進度會消失。

## Demo 範圍

目前包含真實 AI 拆解與重排、預覽確認、Supabase 匿名 session、頁面記憶體中的 Checklist 進度和四個分頁。正式用量配額、工作與階段驗收流程、週回顧、專注計時、Email 綁定和部署網址尚未完成。未設定 Supabase 時，AI 分析會停止並提示，不會回退假回覆。

