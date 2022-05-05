import 'dart:ui';

import 'package:api_clima_dio_bloc/event/clima_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/controller_clima.dart';
import '../repository/repositotry_clima.dart';
import '../states/clima_states.dart';
import 'components/clima_card.dart';
import 'components/today_card.dart';

class PageClima extends StatefulWidget {
  const PageClima({Key? key}) : super(key: key);

  @override
  State<PageClima> createState() => _PageClimaState();
}

class _PageClimaState extends State<PageClima> {
  @override
  void initState() {
    super.initState();
    controller.add(FetchClimaByCity());
  }

  final ControllerClima controller =
      ControllerClima(SuccessClimaStates, RepositoryClima(dio: Dio()));
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: FittedBox(
                fit: BoxFit.cover,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 1.5,
                    sigmaY: 1.5,
                  ),
                  child: Image.asset(
                    'assets/image/ogarotodajanela.jpg',
                  ),
                ),
              ),
            ),
            BlocBuilder(
                bloc: controller,
                builder: (context, state) {
                  if (state is SuccessClimaStates) {
                    return Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black45,
                        child:
                            LayoutBuilder(builder: (buildcontext, constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                textController.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 50),
                              ),
                              SizedBox(
                                width: size.width * 0.79,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.07,
                                      width: size.width * 0.6,
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        controller: textController,
                                        // onChanged: (value) {
                                        //   controller.add(
                                        //       FetchClimaByCity(cidade: value));
                                        // },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.black45,
                                          labelText: 'Cidade',
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade600,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          controller.add(FetchClimaByCity(
                                              cidade: textController.text));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height * 0.18,
                                width: size.width * 0.95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.black45,
                                ),
                                alignment: Alignment.center,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return SizedBox(
                                    width: constraints.maxWidth * 0.97,
                                    height: constraints.maxHeight * 0.90,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.modelClima.forecast.length,
                                      itemBuilder: (context, index) {
                                        final forecast =
                                            state.modelClima.forecast[index];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClimaCard(
                                              height: size.height * 0.15,
                                              width: size.width * 0.25,
                                              day: forecast.day,
                                              temperature: forecast.temperature,
                                              wind: forecast.wind,
                                            ),
                                            ClimaCard(
                                              height: size.height * 0.15,
                                              width: size.width * 0.25,
                                              day: forecast.day,
                                              temperature: forecast.temperature,
                                              wind: forecast.wind,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                              TodayCard(
                                width: constraints.maxWidth * 0.95,
                                height: constraints.maxHeight * 0.4,
                                iconClima: state.getIconClima(),
                                temperature: state.modelClima.temperature,
                                wind: state.modelClima.wind,
                                description: state.modelClima.description,
                                cidade: textController.text,
                              ),
                            ],
                          );
                        })
                        //   ;

                        );
                  }
                  if (state is ErrorClimaStates) {
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.5,
                        width: size.width * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.black45,
                        ),
                        child: Text(
                          state.mensageErrror,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    );
                  }
                  if (state is LoadingClimaStates) {
                    return CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }

                  return Container(
                    height: 520,
                    width: 500,
                    color: Colors.red,
                    // child: TextButton(
                    //     onPressed: () {
                    //       controller.add(FetchClimaByCity(cidade: 'Maringa'));
                    //     },
                    //     child: Text('Aperta')),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

//TERMINAR A PARTE PRA COMPLETAR A URL COM O QUE O USUARIO DIGITAR
