import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simop/model/users_nop.dart';
import 'package:simop/screen/pbbp2/detail_pbbp2.dart';

import 'package:simop/screen/widget/ubah_catatan.dart';
import 'package:simop/services/nop.dart';
import 'package:simop/services/users_nop.dart';

class NOPDisimpanWidget extends StatefulWidget {
  const NOPDisimpanWidget({Key? key}) : super(key: key);

  @override
  _NOPDisimpanWidgetState createState() => _NOPDisimpanWidgetState();
}

class _NOPDisimpanWidgetState extends State<NOPDisimpanWidget> {
  final _nopController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFCFCFC),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(190),
          child: AppBar(
            backgroundColor: Color(0xFFFCFCFC),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Color(0xFF65A25E),
                            size: 24,
                          ),
                          onPressed: () async {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Text(
                        'NOP Disimpan',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    // cari tanggal kegiatan
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFFCFCFC),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x2F1D2429),
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Color(0xFFDA251D),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 0, 0),
                                  child: TextFormField(
                                    controller: _nopController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'NOP',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x2F1D2429),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x2F1D2429),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x2F1D2429),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x2F1D2429),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            toolbarHeight: double.infinity,
            elevation: 0,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: StreamBuilder<List<UsersNOPModel>>(
                stream: UsersNOP.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      final List<UsersNOPModel> usersNOPs = snapshot.data!;
                      return ListView.builder(
                        itemCount: usersNOPs.length,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final UsersNOPModel usersNOP = usersNOPs[index];
                          return Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Container(
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2F1D2429),
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 16, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.map,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 8),
                                                child: Text(
                                                  'NOP',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 8),
                                                child: Text(
                                                  usersNOP.nop,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                              Text(
                                                usersNOP.catatan,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 16, 0),
                                                    child: IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.pen,
                                                        color:
                                                            Color(0xFF111111),
                                                        size: 16,
                                                      ),
                                                      onPressed: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder:
                                                              (bottomSheetContext) {
                                                            return GestureDetector(
                                                              onTap: () => FocusScope
                                                                      .of(
                                                                          context)
                                                                  .requestFocus(
                                                                      _unfocusNode),
                                                              child: Padding(
                                                                padding: MediaQuery.of(
                                                                        bottomSheetContext)
                                                                    .viewInsets,
                                                                child: UbahCatatanWidget(
                                                                    nop: usersNOP
                                                                        .nop,
                                                                    catatan:
                                                                        usersNOP
                                                                            .catatan),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 16, 0),
                                                    child: IconButton(
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.trash,
                                                        color:
                                                            Color(0xFF111111),
                                                        size: 16,
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    SimpleDialog(
                                                                      title:
                                                                          Text(
                                                                        'Hapus NOP?',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleSmall,
                                                                      ),
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              20.0),
                                                                      children: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              await UsersNOP.deleteUsersNOP(usersNOP.nop);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Hapus',
                                                                              style: Theme.of(context).textTheme.titleSmall,
                                                                            ))
                                                                      ],
                                                                    ));
                                                      },
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .chevronRight,
                                                      color: Color(0xFF111111),
                                                      size: 16,
                                                    ),
                                                    onPressed: () async {
                                                      var namaWp = await NOP.getNamaWp(usersNOP.nop);
                                                      var kecamatan = await NOP.getKecamatan(usersNOP.nop);
                                                      var kelurahan = await NOP.getKelurahan(usersNOP.nop);
                                                      Get.to(DetailPBBP2Widget(nop: usersNOP.nop, namawp: namaWp, kecamatan: kecamatan, kelurahan: kelurahan,));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  } else {
                    return SizedBox.shrink();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
