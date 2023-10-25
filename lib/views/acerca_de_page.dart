import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1520911831154-12889531673c?w=512&h=512',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, nulla eu feugiat tristique, risus mauris fermentum sem, a lacinia justo nisi eget ex. Nulla facilisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec tincidunt, felis at luctus dictum, purus ipsum tincidunt leo, vitae ullamcorper purus nisl in ex. Sed ultrices, dui at lacinia tincidunt, erat tortor ultrices purus, non tristique nulla risus ut metus. Nulla facilisi. Suspendisse potenti. In hac habitasse platea dictumst.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1520911831154-12889531673c?w=512&h=512',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, nulla eu feugiat tristique, risus mauris fermentum sem, a lacinia justo nisi eget ex. Nulla facilisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec tincidunt, felis at luctus dictum, purus ipsum tincidunt leo, vitae ullamcorper purus nisl in ex. Sed ultrices, dui at lacinia tincidunt, erat tortor ultrices purus, non tristique nulla risus ut metus. Nulla facilisi. Suspendisse potenti. In hac habitasse platea dictumst.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black,
                    ),
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
