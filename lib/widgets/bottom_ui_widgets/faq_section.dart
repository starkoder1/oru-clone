import 'package:flutter/material.dart';
import '../../models/faq_model.dart';

class FaqSection extends StatefulWidget {
  final List<FaqModel> faqQuestions;

 const FaqSection({super.key, required this.faqQuestions});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  List<bool> _faqExpandedStates = [];

  @override
  void initState() {
    super.initState();
    _faqExpandedStates = List.generate(widget.faqQuestions.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Question',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.faqQuestions.length,
            itemBuilder: (context, index) {
              final faqItem = widget.faqQuestions[index];
              return _buildFaqItem(index: index, faqModel: faqItem);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({required int index, required FaqModel faqModel}) {
    bool isExpanded = _faqExpandedStates[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isExpanded ? Colors.white : Colors.grey.shade100, // White when expanded
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300), // Light grey border
            boxShadow: [
              if (isExpanded)
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), // Shadow on expand
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Hide ExpansionTile divider
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              title: Text(
                faqModel.question,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Always black text
                ),
              ),
              trailing: AnimatedRotation(
                turns: isExpanded ? 0.125 : 0, // 45° rotation on expand
                duration: Duration(milliseconds: 300),
                child: Icon(Icons.add, size: 24, color: Colors.black), // "+" stays as an icon
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _faqExpandedStates[index] = expanded;
                });
              },
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Text(
                    faqModel.answer,
                    style: TextStyle(fontSize: 14, color: Colors.black), // Black text for answer
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
