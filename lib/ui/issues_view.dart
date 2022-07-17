import 'package:flutter/material.dart';
import 'package:github_bugs/bloc/issues/issues_bloc.dart';
import 'package:github_bugs/bloc/issues/issues_event.dart';

import '../class/issue.dart';

class IssuesView extends StatefulWidget {
  const IssuesView({Key? key}) : super(key: key);

  @override
  State<IssuesView> createState() => _IssuesViewState();
}

class _IssuesViewState extends State<IssuesView> {
  final _bloc = IssuesBloc();
  final TextEditingController _searchIssueController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _issuePage = 1;


  // Dispose resources to avoid memory leaks
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.issuesEventSink.add(InitializeIssueData(_issuePage));

    _scrollController.addListener(() {
      // Detect scroll reaching an edge
      if (_scrollController.position.atEdge) {
        // Detect if the scroll is at bottom position
        if (_scrollController.position.pixels != 0) {
          // Fetch next page from API.
          _issuePage = _issuePage + 1;
          _bloc.issuesEventSink.add(InitializeIssueData(_issuePage));
        }
      }
    });

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Text(
                          'GitHub Repo Issues Analyzer',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 50.0,
                        child: TextField(
                          controller: _searchIssueController,
                          onChanged: (issueTitle) =>  _bloc.issuesEventSink.add(SearchIssue(issueTitle)),
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black54, width: 2.0),
                                borderRadius: BorderRadius.circular(45),
                              ),

                              // Do not change style when TextField is tapped
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black54, width: 2.0),
                                borderRadius: BorderRadius.circular(45),
                              ),

                              hintText: 'Search issue',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(left: 20, right: 10),
                                child: const Icon(Icons.search_rounded, size: 30, color: Colors.red,),
                              )
                          ),
                        ),
                      ),

                      Container(
                          margin: const EdgeInsets.only(left: 0, top: 20, bottom: 20),
                          height: 30.0,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45.0),

                                    ),
                                    side: const BorderSide(width: 1.0, color: Colors.grey),
                                    primary: Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {

                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Order by ',
                                      style: TextStyle(fontSize: 14, color: Colors.black,),
                                      children: <TextSpan>[
                                        TextSpan(text: 'creation', style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                              ),

                              const SizedBox(width: 15,),

                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45.0),

                                    ),
                                    side: const BorderSide(width: 1.0, color: Colors.grey),
                                    primary: Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Order by ',
                                      style: TextStyle(fontSize: 14, color: Colors.black,),
                                      children: <TextSpan>[
                                        TextSpan(text: 'updated', style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                              ),

                              const SizedBox(width: 15,),

                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45.0),

                                    ),
                                    side: const BorderSide(width: 1.0, color: Colors.grey),
                                    primary: Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Order by ',
                                      style: TextStyle(fontSize: 14, color: Colors.black,),
                                      children: <TextSpan>[
                                        TextSpan(text: 'comments', style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                              ),

                              const SizedBox(width: 20.0),
                            ],
                          )
                      ),

                      Expanded(
                          child: StreamBuilder<List<Issue>>(
                            stream: _bloc.issues,
                            initialData: null,
                            builder: (BuildContext context, AsyncSnapshot<List<Issue>> snapshot){
                              if (snapshot.hasError) {
                                return const Center(child: Text('Unexpected error, try again later.'));
                              } else if (snapshot.hasData) {
                                return GridView.builder(
                                  controller: _scrollController,
                                  // Disable glow on scroll end
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      // TODO: Pass the issue id to the next view
                                      onTap: () {

                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color(0xFFFFFFFF),
                                              Color(0xFFFFFFFF),
                                            ],
                                          ),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)
                                          ),
                                          border: Border.all(color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data?.elementAt(i).title}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              //const SizedBox(height: 5,),
                                              const Divider(thickness: 1, height: 20, color: Colors.grey),
                                              //const SizedBox(height: 5,),

                                              Flexible(
                                                child: Text(
                                                  '${snapshot.data?.elementAt(i).description}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.black
                                                  ),
                                                  //overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 20.0,
                                    mainAxisSpacing: 20,
                                  ),
                                );
                              } else {
                                return const Center(child: CircularProgressIndicator(),);
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}