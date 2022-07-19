import 'package:flutter/material.dart';
import 'package:github_bugs/class/detail_issue.dart';
import '../bloc/details/details_bloc.dart';
import '../bloc/details/details_event.dart';
import 'package:intl/intl.dart';

class IssueInfoView extends StatefulWidget {
  final int issueNumber;
  const IssueInfoView({super.key, required this.issueNumber});

  @override
  State<IssueInfoView> createState() => _IssueInfoViewState();
}

class _IssueInfoViewState extends State<IssueInfoView> {
  final _bloc = IssueDetailBloc();

  @override
  void initState(){
    _bloc.issuesDetailsEventSink.add(InitializeIssueDetailedData(widget.issueNumber));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.red,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<IssueDetail>(
          stream: _bloc.issueDetails,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<IssueDetail> snapshot){
            if (snapshot.hasError) {
              return const Center(child: Text('Unexpected error, try again later.',
                  style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 10)),);
            } else if (snapshot.hasData) {
              return Column(
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 65, left: 45),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage('${snapshot.data?.user?.avatar}'),
                                  ),
                                ),

                                const SizedBox(height: 10,),

                                SizedBox(
                                  width: 100,
                                  child: Text('${snapshot.data?.user?.login}', style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, height: 1.4), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                                )
                              ],
                            )
                          ),

                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 20, right: 20, left: 50),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),

                                          const SizedBox(width: 10,),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Creation:', style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10)),
                                                Text(DateFormat.MMMMd().add_Hm().format(DateTime.parse(snapshot.data!.creationDate!)), style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 10,),

                                      Row(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(
                                                  Icons.lock_open,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),

                                          const SizedBox(width: 10,),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('State:', style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10)),
                                                Text('${snapshot.data?.state}', style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 10,),

                                      Row(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(
                                                  Icons.numbers,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),

                                          const SizedBox(width: 10,),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Id:', style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10)),
                                                Text('${snapshot.data?.number}', style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 10,),

                                      Row(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(
                                                  Icons.message,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),

                                          const SizedBox(width: 10,),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Comments:', style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10)),
                                                Text('${snapshot.data?.numComments}', style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 10,),

                                      Row(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(
                                                  Icons.update,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),

                                          const SizedBox(width: 10,),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Updated:', style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10)),

                                                Text(DateFormat.MMMMd().add_Hm().format(DateTime.parse(snapshot.data!.updateDate!)), style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ]
                                ),
                              )
                          ),
                        ]
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                            child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:[
                                  Text('${snapshot.data?.title}\n', style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,),),
                                  Text('${snapshot.data?.description}', style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal, height: 1.4),),

                                  const Divider(color: Colors.red, height: 40, thickness: 2,),

                                  const Text('Asignee:', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child:
                                              snapshot.data?.assignee?.login != "Unassigned"?
                                              CircleAvatar(
                                               backgroundImage: NetworkImage('${snapshot.data?.assignee?.avatar}'),
                                              ):
                                              const CircleAvatar(
                                                backgroundColor: Colors.red,
                                              )

                                            ),

                                            const SizedBox(height: 10,),

                                            Text('${snapshot.data?.assignee?.login}', style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),),

                                          ],
                                        )
                                    ),
                                  ),

                                  const SizedBox(height: 20,),
                                ]
                            )
                        )
                    ),
                    )

                  ]
              );
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
    );
  }
}