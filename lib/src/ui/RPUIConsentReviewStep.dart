part of research_package_ui;

class RPUIConsentReviewStep extends StatefulWidget {
  final RPConsentReviewStep step;
//  final RPConsentDocument consentDocument;
//  final String text;
//  final String reasonForConsent;

  RPUIConsentReviewStep(this.step);

  @override
  _RPUIConsentReviewStepState createState() => _RPUIConsentReviewStepState();
}

class _RPUIConsentReviewStepState extends State<RPUIConsentReviewStep> {
  Widget _reviewCellBuilder(BuildContext context, int index) {
    if (index == 0) {
      // return the header
      return Column(
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 10.0),
//            child: Text(
//              'Review',
//              style: RPStyles.H1,
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: Text(
              'Review this form below, and tap AGREE if you\'re ready to continue.',
              style: RPStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    index -= 1;

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              widget.step.consentDocument.sections[index].title,
              style: RPStyles.H2,
            ),
          ),
          Text(
            widget.step.consentDocument.sections[index].content,
            style: RPStyles.bodyText,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showConsentDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(widget.step.text),
            content: Text(widget.step.reasonForConsent),
            actions: <Widget>[
              FlatButton(
                child: Text("CANCEL"),
                onPressed: () => blocTask.sendStatus(StepStatus.Canceled),
              ),
              FlatButton(
                child: Text("AGREE"),
                onPressed: widget.step.consentDocument.signatures != []
                    ? () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return NameInputRoute(
                            signaturePageTitle: widget.step.consentDocument.signaturePageTitle,
                          );
                        }));
                      }
                    : () => print('Agree'),
                textTheme: ButtonTextTheme.primary,
              )
            ],
          );
        },
      );
    }

    return Theme(
      data: RPStyles.cachetTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Review'), //TODO: Localization
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: widget.step.consentDocument.sections.length + 1,
          itemBuilder: _reviewCellBuilder,
        ),
        persistentFooterButtons: <Widget>[
          FlatButton(
              child: Text(
                "DISAGREE",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () => blocTask.sendStatus(StepStatus.Canceled)),
          FlatButton(child: Text("AGREE"), onPressed: () => _showConsentDialog()), //TODO: Localization
        ],
      ),
    );
  }
}

class NameInputRoute extends StatefulWidget {
  final String signaturePageTitle;
  NameInputRoute({this.signaturePageTitle});

  @override
  _NameInputRouteState createState() => _NameInputRouteState();
}

class _NameInputRouteState extends State<NameInputRoute> {
  bool _isNameFilled;
  bool _isSignatureAdded;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  var _signature = Signature(
    height: 150,
    width: 300,
    backgroundColor: Colors.transparent,
  );

  Widget _signatureCanvas() {
    return GestureDetector(
      onPanUpdate: (e) {
        setState(() {
          if (_signature.isNotEmpty) {
            _isSignatureAdded = true;
          }
        });
      },
      child: Container(
        child: _signature,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  void _checkNameNotEmpty() {
    setState(() {
      _isNameFilled = (_firstNameController.text != '' && _lastNameController.text != '');
    });
  }

  @override
  void initState() {
    _isNameFilled = false;
    _isSignatureAdded = false;
    _firstNameController.addListener(_checkNameNotEmpty);
    _lastNameController.addListener(_checkNameNotEmpty);
    super.initState();
  }

  Widget _nameFields() {
    return Column(
      children: <Widget>[
        TextFormField(
          autofocus: true,
          controller: _firstNameController,
          decoration: InputDecoration(
            labelText: "First Name",
          ), //TODO: Localization
        ),
        TextFormField(
          controller: _lastNameController,
          decoration: InputDecoration(labelText: "Last Name"), //TODO: Localization
        ),
      ],
    );
  }

  Widget _signingField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: <Widget>[
            Text(
              'Please sign using your finger on the line below.', //TODO: Localization
              style: RPStyles.bodyText,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: _signatureCanvas(),
            ),
            FlatButton(
              child: Text("Clear"),
              onPressed: () {
                _signature.clear();
                setState(() {
                  _isSignatureAdded = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: RPStyles.cachetTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.signaturePageTitle),
        ),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            _nameFields(),
            _signingField(),
          ],
        ),
        persistentFooterButtons: <Widget>[
          FlatButton(
            onPressed: (_isNameFilled && _isSignatureAdded) ? () => blocTask.sendStatus(StepStatus.Finished) : null,
            child: Text('NEXT'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
