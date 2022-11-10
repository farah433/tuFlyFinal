import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(image) => pw.Padding(
            padding: pw.EdgeInsets.all(25),
            child: pw.Column(
              children: [
                pw.Image(image, height: 50, width: 50),
                pw.Text('     tuFly', style: pw.TextStyle(fontSize: 20, color: PdfColor(158,53,7)),),
                pw.SizedBox(height: 20,),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('NAIROBI', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                    // pw.Icon(Icons.flight_land_rounded, color: PdfColor(158,53,7),),
                    pw.Text('MOMBASA', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                    pw.Text('17.05', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                  ],
                ),
                pw.SizedBox(height: 10,),
                pw.Text('TRAVELLER', style: pw.TextStyle(fontSize: 20, color:PdfColor(158,53,7)),),
                pw.Text('First name and Last name', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                pw.SizedBox(height: 10,),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text('DATE', style: pw.TextStyle(fontSize: 20, color:PdfColor(158,53,7)),),
                        pw.Text('10/11/22', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                        
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text('FLIGHT NO.', style: pw.TextStyle(fontSize: 20, color:PdfColor(158,53,7)),),
                        pw.Text('jhkgtu', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10,),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Container(
                        height: 55,
                        width: 55,
                        decoration: pw.BoxDecoration(
                          color: PdfColor(252,151,73, 0.5),
                          borderRadius: pw.BorderRadius.circular(5),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(8.0),
                          // child: Image.asset('images/$newCompanyName.png'),
                        ),
                      ),
                      pw.Text('Fly540', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                        
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text('SEATS', style: pw.TextStyle(fontSize: 20, color:PdfColor(158,53,7)),),
                        pw.Text('DE, FE', style: pw.TextStyle(fontSize: 16, color: PdfColor(0,0,0)),),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10,),
                pw.Text('Thanks for choosing our service!', style: pw.TextStyle(fontSize: 16, color: PdfColor(128,128,128)),),
                pw.SizedBox(height: 5,),
                pw.Text('Contact the branch for any clarifications.', style: pw.TextStyle(fontSize: 16, color: PdfColor(128,128,128)),),
                pw.SizedBox(height: 15,),
              ],
            ),
            );