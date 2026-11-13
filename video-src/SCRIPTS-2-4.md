# Tòa án AI · scripts, round 2

**Changes after approval (12 Nov):**
- No more A/B/C. Each vote card asks an open question ("… chuyện gì sẽ xảy ra? Vì sao?"), with two blank notes, "Đoán" and "Vì sao". The last line is "Kết quả là …", and the stamp shows the outcome only.
- Case 4, fact 3 is now "Hà Nội là một trong 5 thành phố trực thuộc trung ương". It was true before 7/2025. Since 30/4/2026 there are 7: Hà Nội, TP.HCM, Hải Phòng, Đà Nẵng, Cần Thơ, Huế, Đồng Nai ([CafeF](https://cafef.vn/da-nang-khong-con-la-thanh-pho-truc-thuoc-trung-uong-rong-nhat-viet-nam-188260502111245306.chn)).
- The `script.json` files in each case folder are the final narration.


`[ ]` = what we see. The line after it is the narration (also the caption).

## New order

| Slide | Case | Student | Answer |
|---|---|---|---|
| 29 · Tình huống 1 | Tiếng Anh: tự đố, dồn một tối | girl | **B** · Nhớ một phần |
| 30 · Tình huống 2 | Khoa học tự nhiên: nhờ AI viết bài quan sát cây *(already built)* | boy | **C** · Quên |
| 31 · Tình huống 3 | Ngữ văn: AI chỉ lỗi, mình tự sửa *(approved)* | boy | **A** · Nhớ |
| 32 · Tình huống 4 | Giáo dục địa phương: AI dùng số liệu cũ về Hà Nội | girl | **C** · Điểm thấp |

The answers run B, C, A, C, so there is no good-then-bad pattern. Case 4 ends the round with a new idea: AI can be out of date and still sound sure.

Case 4 asks a different question, because memory is not the point there. Its options are **A Điểm cao · B Điểm trung bình · C Điểm thấp**. Cases 1–3 keep **A Nhớ · B Nhớ một phần · C Quên**. The deck will show the right options under each video.

---

## Tình huống 1 · Tiếng Anh: tự đố nhưng dồn một tối → **B · Nhớ một phần**

Topic: Tiếng Anh 6 (Global Success), Unit 4 *My neighbourhood*. Changed as you asked: she keeps about half.

**Phần 1**
1. `[Bedroom, the clock shows 9:00 at night. An English book.]`
   Tối thứ Năm, chín giờ. Mai kiểm tra từ vựng Tiếng Anh Unit 4, bạn ấy chưa ôn chữ nào.
2. `[Tablet close-up. She types.]`
   Bạn ấy nhờ Gemini đố liền ba mươi câu, mỗi lần một câu.
   - On screen, she types: *Đố mình 30 câu từ vựng Unit 4 My neighbourhood, mỗi lần một câu nhé.*
3. `[Quick quiz: "Câu 1/30: narrow nghĩa là gì?" → "hẹp" → "Đúng!". The counter runs to 30/30, and the clock goes from 9:00 to 10:00.]`
   Bạn ấy trả lời từng câu, sai thì làm lại. Đến mười giờ thì xong đủ ba mươi câu.
4. `[Classroom next day. Test paper with 8.]`
   Hôm sau làm bài kiểm tra, bạn ấy được tám điểm.
5. `[Vote card.]`
   Theo đội của em, hai tuần sau bạn ấy còn nhớ những từ này không?

**Phần 2**
6. `[Calendar flips fast through two weeks. "Hai tuần sau".]`
   Hai tuần sau, cả lớp ôn thi học kỳ.
7. `[A list of 12 words. Six light up green (narrow, noisy, peaceful, crowded, modern, temple). Six stay grey (cathedral, convenient, historic, railway station, square, memorial).]`
   Bạn ấy còn nhớ khoảng một nửa số từ. Nửa còn lại thì đã quên.
8. `[She opens the book and starts again on the grey words.]`
   Bạn ấy phải học lại những từ đã quên.
9. `[Stamp: "B · Nhớ một phần".]`
   Đáp án là B. Bạn ấy nhớ một phần.

---

## Tình huống 2 · Khoa học tự nhiên: nhờ AI viết bài quan sát → **C · Quên**

Already built. The only change is the title ribbon, "Tình huống 1" → "Tình huống 2".

---

## Tình huống 3 · Ngữ văn: AI chỉ lỗi, mình tự sửa → **A · Nhớ** *(approved, unchanged)*

**Phần 1**
1. `[Bedroom at night. He finishes writing, puts the pen down.]`
   Cô giao bài văn kể lại một trải nghiệm. Bạn ấy tự viết xong bài về chuyến về quê.
2. `[Tablet close-up. He types: "Đọc bài văn của mình và chỉ ra 3 chỗ còn yếu. Đừng viết lại hộ mình nhé."]`
   Bạn ấy nhờ Gemini chỉ ra ba chỗ còn yếu, và dặn là đừng sửa hộ.
3. `[Gemini: 1. Mở bài dài sáu câu, chưa vào thẳng câu chuyện. 2. Chữ “rất” lặp lại chín lần. 3. Kết bài chưa nói em cảm thấy thế nào.]`
   Gemini chỉ ra ba chỗ. Mở bài dài, chữ “rất” lặp lại nhiều lần, kết bài chưa có cảm xúc.
4. `[He crosses out lines and rewrites. The clock moves 20 minutes. He sighs, then keeps going.]`
   Bạn ấy tự sửa từng chỗ. Mất thêm hai mươi phút, lâu hơn các bạn khác.
5. `[Classroom on Monday. The teacher hands the essay back with a smile.]`
   Thứ Hai nộp bài, cô khen phần kết bài có cảm xúc.
6. `[Vote card.]`
   Theo đội của em, tuần sau viết bài mới, bạn ấy còn nhớ ba lỗi đó không?

**Phần 2**
7. `[Calendar flips. "Một tuần sau".]` Một tuần sau, cả lớp viết một bài văn mới ngay trên lớp.
8. `[He writes. A thought bubble shows the three notes; the first two get ticked.]` Bạn ấy viết mở bài ngắn, vào thẳng câu chuyện, và để ý không lặp chữ “rất”.
9. `[The third note gets ticked as he writes the ending.]` Đến kết bài, bạn ấy nhớ viết thêm cảm xúc của mình.
10. `[Stamp: "A · Nhớ".]` Đáp án là A. Bạn ấy vẫn nhớ.

---

## Tình huống 4 · Giáo dục địa phương: tìm hiểu về Hà Nội, AI dùng số liệu cũ → **C · Điểm thấp** *(new)*

Subject: Giáo dục địa phương Hà Nội lớp 6. This is the grade 6 subject for local topics, the nearest thing to TNXH at this level.

The facts (checked):
- From 1 July 2025 Vietnam has **34** tỉnh, thành, down from 63 ([Nhân Dân](https://nhandan.vn/quoc-hoi-thong-qua-nghi-quyet-ve-sap-xep-don-vi-hanh-chinh-cap-tinh-ca-nuoc-con-34-tinh-thanh-post886206.html)).
- Local government now has two levels, with no quận/huyện. Hà Nội has **126** xã, phường (51 phường, 75 xã), down from 30 quận/huyện and 526 xã/phường ([Chính phủ](https://xaydungchinhsach.chinhphu.vn/sap-xep-dvhc-danh-sach-126-xa-phuong-moi-cua-ha-noi-119250622193659228.htm)).
- Hà Nội's area is about 3.360 km².

An AI that learned from older pages gives the old numbers in a confident voice. The 2025 change is recent and widely known, so this mistake is believable.

**Phần 1**
1. `[Classroom. The teacher hands out the task. Close-up of the sheet: "Tìm hiểu về Hà Nội: diện tích, các đơn vị hành chính, cả nước có bao nhiêu tỉnh, thành. Dùng số liệu mới nhất, ghi rõ nguồn."]`
   Cô giao bài Giáo dục địa phương. Mỗi bạn tìm hiểu về Hà Nội, dùng số liệu mới nhất và ghi rõ nguồn.
2. `[Bedroom in the evening. Tablet close-up. She types: "Cho mình 3 thông tin chính về Hà Nội để làm bài nhé."]`
   Tối hôm đó, bạn ấy hỏi Gemini cho nhanh.
3. `[Gemini's three facts appear one by one:]`
   Gemini đưa ra ba thông tin, trình bày rất gọn và nghe rất chắc chắn.
   - 1. Hà Nội là thủ đô của Việt Nam, diện tích khoảng 3.360 km². *(right)*
   - 2. Hà Nội có 30 quận, huyện và thị xã. *(out of date)*
   - 3. Cả nước có 63 tỉnh, thành phố. *(out of date)*
4. `[She copies the three facts onto a poster, writes "Nguồn: Gemini" at the bottom, and reads it aloud to learn it.]`
   Bạn ấy chép cả ba vào bài, ghi nguồn là Gemini, rồi đọc to cho thuộc.
5. `[Vote card, with the score options.]`
   Theo đội của em, khi cô chấm bài, bạn ấy được điểm cao, trung bình hay thấp?

**Phần 2**
6. `[Calendar flips. "Một tuần sau".]`
   Một tuần sau, bạn ấy lên thuyết trình bài về Hà Nội.
7. `[She presents confidently with the poster. A classmate raises a hand.]`
   Bạn ấy nói rất tự tin. Một bạn giơ tay hỏi lại, Hà Nội bây giờ đâu còn quận, huyện nữa?
8. `[The teacher shows a news card: "Từ 1/7/2025 · Cả nước: 34 tỉnh, thành · Hà Nội: 126 xã, phường, không còn quận, huyện".]`
   Cô giải thích, từ tháng Bảy năm 2025, cả nước còn ba mươi tư tỉnh, thành. Hà Nội không còn quận, huyện, mà có một trăm hai mươi sáu xã, phường.
9. `[The poster comes back: facts 2 and 3 crossed out in red, fact 1 ticked, score 4.]`
   Hai trong ba thông tin của bạn ấy đã cũ. Bạn ấy chỉ được bốn điểm.
10. `[Stamp: "C · Điểm thấp".]`
    Đáp án là C. Gemini dùng thông tin cũ, và bạn ấy không kiểm tra lại.

---

## Slide text after approval (Phần 1 card · outcome · why)

| Slide | Phần 1 | Outcome | Why |
|---|---|---|---|
| 29 | Tối trước ngày kiểm tra, bạn ấy nhờ Gemini đố 30 câu từ vựng liền trong một tiếng và được điểm 8. | Nhớ một phần. Hai tuần sau ôn thi học kỳ, bạn ấy còn nhớ khoảng một nửa số từ. | Tự đố là đúng (bậc 3), nhưng dồn một tối là trái Rải đều, ngủ đủ. Nên mỗi tối 10 câu trong ba tối. |
| 30 | Cô giao quan sát 5 loài cây quanh nhà rồi xếp nhóm. Bạn ấy ngại ra vườn, nhờ Gemini viết hộ, chép vào vở và được cô khen. | Quên. Giờ học ngoài vườn trường, cô chỉ cây dương xỉ và hỏi đây là cây gì, có đặc điểm gì, thuộc loại nào. Bạn ấy không trả lời được vì chưa từng thấy cây dương xỉ ngoài đời, dù bài của mình có ghi. | Chép bài AI viết là bậc 1. Tự ra vườn nhìn, sờ, ghi lại mới là bậc 3; AI chỉ nên giúp kiểm tra cách xếp nhóm. |
| 31 | Viết xong bài văn, bạn ấy nhờ Gemini chỉ ra ba chỗ yếu nhưng không sửa hộ, rồi tự sửa. Mất thêm 20 phút. | Nhớ. Bài văn tuần sau, bạn ấy tự tránh được đúng những lỗi đó. | AI chỉ chỗ yếu, bạn vẫn là người làm: bậc 3 và Luyện nhiều chỗ yếu. |
| 32 | Tìm hiểu về Hà Nội, bạn ấy hỏi Gemini ba thông tin chính, chép vào bài, ghi nguồn là Gemini, không kiểm tra lại. | Điểm thấp. Hai trong ba thông tin đã cũ: Hà Nội không còn quận, huyện, cả nước còn 34 tỉnh, thành. | AI có thể dùng thông tin đã cũ mà vẫn nói rất chắc chắn. Với số liệu, kiểm tra lại ở nguồn chính thức mới nhất hoặc hỏi thầy cô.
