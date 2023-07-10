import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/utils/appbar_utils.dart';
import 'package:gen_pdf/widgets/base_form.dart';
import 'package:gen_pdf/widgets/consigne/form_inputs.dart';

class NewConsigner extends StatelessWidget {
  static String route = "newConsigner";
  const NewConsigner({super.key});

  @override
  Widget build(BuildContext context) {
    var consigner =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>?;

    var isEditing = consigner != null;

    return Scaffold(
      appBar: AppBar(
        leading: AppBarUtils.leadingWidget,
        title: Text(isEditing ? "Modificar Cliente" : "Crear cliente"),
        centerTitle: false,
        leadingWidth: AppBarUtils.appbarSpace?.left,
        toolbarHeight: AppBarUtils.appbarHeight,
        flexibleSpace: AppBarUtils.platformAppBarFlexibleSpace,
      ),
      body: BlocListener<ConsignerBloc, ConsignerState>(
        listener: (context, state) {
          if (state is ConsignerSaved) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                content:
                    Text(isEditing ? "Cliente modificado" : "Cliente creado"),
              ),
            );
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
                child: SafeArea(
                    minimum: const EdgeInsets.fromLTRB(10, 12, 10, 20),
                    child: Column(
                      children: [
                        BaseForm(
                          initialValues: consigner,
                          inputs: formInputs(),
                          onSubmit: (values) async {
                            if (isEditing) {
                              context.read<ConsignerBloc>().add(EditConsigner(
                                  {...values, "id": consigner['id']}));
                              return;
                            } else {
                              context
                                  .read<ConsignerBloc>()
                                  .add(CreateConsigner(values));
                            }
                          },
                        )
                      ],
                    )))),
      ),
    );
  }
}
