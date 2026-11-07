# OneStep Demo

繁體中文、手機優先的目標管理 demo。輸入目標後，Supabase Edge Function 以 GPT 產生結構化路線圖；預覽確認後才儲存。Checklist 進度保存於 Supabase，並可用目前進度產生 AI 重排預覽。

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

你已建立 `OPENAI_API_KEY` Secret 名稱；請確認該 Secret 的值已填真正的 OpenAI API key。金鑰留在 Supabase Edge Function Secrets，絕不可放入前端、聊天或 GitHub。匿名登入需在 Supabase Auth 啟用 Anonymous Sign-ins。RLS 只允許使用者讀寫自己的目標。

## 使用流程

輸入目標、原因、期限、每日時間及阻礙，按「分析並預覽計畫」。GPT 呼叫失敗會顯示錯誤，不使用假資料。按「使用這份計畫」後才建立目標；路線圖可勾 checklist，再按「AI 依進度重新規劃」，預覽確認後套用。

## Demo 範圍

目前包含真實 AI 拆解與重排、預覽確認、Supabase 匿名 session、目標讀寫、RLS、Checklist 持久化與四個分頁。正式用量配額、工作與階段驗收流程、週回顧、專注計時、Email 綁定和部署網址尚未完成，不會在介面宣稱已完成。未設定 Supabase 時，AI 分析會停止並提示，不會回退假回覆。

