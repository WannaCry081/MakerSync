import "package:flutter/material.dart";


class MSWrapperWidget extends StatelessWidget {
  
  final Widget? child;
  
  const MSWrapperWidget({ 
    super.key,
    this.child 
  });

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child : LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child : ConstrainedBox(
              constraints : BoxConstraints(
                minHeight : constraints.maxHeight
              ),

              child : IntrinsicHeight(
                child : child
              )
            )
          );
        }
      )
    );
  }
}