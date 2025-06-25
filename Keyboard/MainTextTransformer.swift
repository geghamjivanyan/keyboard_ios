import Foundation

class MainTextTransformer {
    private var conversionRules: [(from: String, to: String)] = []

    init() {
        loadConversionRules()
    }

    private func loadConversionRules() {
        let csvData = """
        ء,أ
        ـَ,ـا
        ً,ًـ
        ٍ,ٍـ
        ٌ,ٌـ
        ـضض,ـالضّ
        ـصص,ـالصّ
        ـثث,ـالثّ
        ـدد,ـالدّ
        ـشش,ـالشّ
        ـسس,ـالسّ
        ـتت,ـالتّ
        ـنن,ـالنّ
        ـطط,ـالطّ
        ـرر,ـالرّ
        ـزز,ـالزّ
        ـظظ,ـالظّ
        ـذذ,ـالذّ
        ـلل,ـالل
        ضض,ضّ
        صص,صّ
        ثث,ثّ
        دد,دّ
        شش,شّ
        سس,سّ
        لل,لّ
        تت,تّ
        نن,نّ
        طط,طّ
        رر,رّ
        زز,زّ
        ظظ,ظّ
        ذذ,ذّ
        قق,قّ
        فف,فّ
        غغ,غّ
        عع,عّ
        هه,هّ
        خخ,خّ
        حح,حّ
        جج,جّ
        يي,يّ
        بب,بّ
        مم,مّ
        كك,كّ
        وو,وّ
        ـلق,ـالق
        ـلف,ـالف
        ـلغ,ـالغ
        ـلع,ـالع
        ـله,ـاله
        ـلخ,ـالخ
        ـلح,ـالح
        ـلج,ـالج
        ـلي,ـالي
        ـلب,ـالب
        ـلم,ـالم
        ـلك,ـالك
        ـلء,ـالء
        ـلو,ـالو
        ـءَ,ـأَ
        ـءِ,ـإ
        ـءُ,ـأُ
        ِء,ِئ
        ءِ,ئِ
        ُء,ُؤ
        ءُ,ؤُ
        َء,َأ
        ءَ,أَ
        أََ,آ
        ءََ,ءا
        ـفَؤُ,ـفَأُ
        ـفَئِ,ـفَإِ
        ـكَؤُ,ـكَأُ
        ـكَئِ,ـكَإِ
        كَإِيب,كَئيب
        ـوَكَؤُ,ـوَكَأُ
        ـوَكَئِ,ـوَكَإِ
        وَكَؤُ,وَكَأُ
        وَكَئِ,وَكَإِ
        فَكَالؤُ,فَكَالأُ
        فَكَالئِ,فَكَالإِ
        وَكَالؤُ,وَكَالأُ
        وَكَالئِ,وَكَالإِ
        كَلِئَ,كَلِأَ
        كَلِؤُ,كَلِأُ
        كَلِئِ,كَلِإِ
        كَبِئَ,كَبِأَ
        كَبِئُ,كَبِأُ
        كَبِئِ,كَبِإِ
        ـبِئَ,ـبِأَ
        ـبِئُ,ـبِأُ
        ـبِئِ,ـبِإِ
        أَبِئَ,أَبِأَ
        أَبِئُ,أَبِأُ
        أَبِئِ,أَبِإِ
        ـلِئَ,ـلِأُ
        ـلِئُ,ـلِأُ
        ـلِئِ,ـلِإِ
        أَلِئَ,أَلِأَ
        ألِئُ,ألِأُ
        أَلِئِ,أَلِإِ
        وَلِئَ,وَلِأَ
        وَلِئُ,وَلِاُ
        وَلِئِ,وَلِإِ
        ـوَؤُ,وَأُ
        ـوئِ,ـوَإِ
        ـوَبِئَ,ـوَبِأَ
        ـوَبِئُ,ـوَبِأُ
        ـوَبِئِ,ـوَبِإِ
        ـفَبِئَ,ـفَبِأَ
        ـفَبِئُ,ـفَبِأُ
        ـفَبِئِ,ـفَبِإِ
        فَلِئَ,فَلِأَ
        فَلِئُ,فَلِأُ
        فَلِئِ,فَلِإِ
        ـلِلؤُ,ـلِلأُ
        ـلِلئِ,ـلِلإِ
        ـأَلِلؤُ,ـاَلِلأُ
        ـأَلِلئِ,ـأَلِلإِ
        وَلِلؤُ,وَلِلأُ
        وَلِلئِ,وَلِلإِ
        فَلِلؤُ,فَلِلأُ
        فَلِلئِ,فَلِلإِ
        فَوَالؤُ,فَوَالأُ
        فَوَالئِ,فَوَالإِ
        فَالؤُ,فَالأُ
        فَالئِ,فَالإِ
        بَِ,بِا
        وَبِالؤ,وَبِالأُ
        وَبِالئِ,وَبِالإِ
        ـالؤُ,الأُ
        ـالئِ,ـالإِ
        َّ,َّ
        ُّ,ُّ
        ِّ,ِّ
        َ.,ًـ
        اءَ.,اءًـ
        أَ.,أًـ
        ةَ.,ةًـ
        اَ.,اًـ
        ى.,ىًـ
        ُ.,ٌـ
        ِ.,ٍـ
        وءََ,وءا
        ـَ.,أَن
        ـِ.,إِن
        أُلائِك,أولئِك
        الرَحمان,الرَحمن
        إِلاه,إله
        هاذا,هذا
        هاؤُلاء,هؤُلاء
        هاأَنا,هأنا
        عَبدَدّ,عَبدَالد
        عَبدَزّ,عَبدَالز
        عَبدَطّ,عَبدَالط
        عَبدَنّ,عَبدَالن
        عَبدَسّ,عَبدَالس
        عَبدَشّ,عَبدَالش
        عَبدَتّ,عَبدَالت
        عَبدَثّ,عَبدَالث
        عَبدَذّ,عَبدَالذ
        عَبدَضّ,عَبدَالض
        عَبدَظّ,عَبدَالظ
        عَبدُدّ,عَبدُالد
        عَبدُزّ,عَبدُالز
        عَبدُطّ,عَبدُالط
        عَبدُنّ,عَبدُالن
        عَبدُسّ,عَبدُالس
        عَبدُشّ,عَبدُالش
        عَبدُتّ,عَبدُالت
        عَبدُثّ,عَبدُالث
        عَبدُذّ,عَبدُالذ
        عَبدُضّ,عَبدُالض
        عَبدُظّ,عَبدُالظ
        عَبدِدّ,عَبدِالد
        عَبدِزّ,عَبدِالز
        عَبدِطّ,عَبدِالط
        عَبدِنّ,عَبدِالن
        عَبدِسّ,عَبدِالس
        عَبدِشّ,عَبدِالش
        عَبدِتّ,عَبدِالت
        عَبدِثّ,عَبدِالث
        عَبدِذّ,عَبدِالذ
        عَبدِضّ,عَبدِالض
        عَبدِظّ,عَبدِالظ
        عَبدَل,عَبدَال
        عَبدِل,عَبدِال
        عَبدُل,عَبدُال
        عَبدَالءِ,عَبدَالإ
        عَبدَالءُ,عَبدَالأُ
        حَتَّاـ,حَتّىـ
        عَلاـ,عَلىـ
        بَلاـ,بَلىـ
        إلاـ,إلىـ
        مَتاـ,مَتىـ
        عيساـ,عيسىـ
        موساـ,موسىـ
        لَداـ,لَدىـ
        أَنّاـ,أَنّىـ
        أولاـ,أولىـ
        رَعاـ,رَعىـ
        رَماـ,رَمىـ
        """

        // Parse CSV data
        let lines = csvData.components(separatedBy: .newlines)
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if !trimmedLine.isEmpty {
                let components = trimmedLine.components(separatedBy: ",")
                if components.count >= 2 {
                    let from = components[0].trimmingCharacters(in: .whitespaces)
                    let to = components[1].trimmingCharacters(in: .whitespaces)
                    if !from.isEmpty && !to.isEmpty {
                        conversionRules.append((from: from, to: to))
                    }
                }
            }
        }

        // Sort rules by length (longest first) to handle overlapping patterns correctly
        conversionRules.sort { $0.from.count > $1.from.count }
    }

    func convert(_ text: String) -> String {
        var result = text

        // Apply all conversion rules
        for rule in conversionRules {
            result = result.replacingOccurrences(of: rule.from, with: rule.to)
        }

        return result
    }

    // Alternative method that shows which conversions were applied
    func convertWithLog(_ text: String) -> (result: String, conversions: [(from: String, to: String)]) {
        var result = text
        var appliedConversions: [(from: String, to: String)] = []

        for rule in conversionRules {
            if result.contains(rule.from) {
                result = result.replacingOccurrences(of: rule.from, with: rule.to)
                appliedConversions.append(rule)
            }
        }

        return (result: result, conversions: appliedConversions)
    }

    // Method to get all available conversion rules
    func getAllRules() -> [(from: String, to: String)] {
        return conversionRules
    }

    // Method to add custom conversion rule
    func addRule(from: String, to: String) {
        conversionRules.append((from: from, to: to))
        // Re-sort to maintain proper order
        conversionRules.sort { $0.from.count > $1.from.count }
    }
}
