<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '$da8ga`r)THj}aeauc+;oO~FM]{Bmpi)y.Sl@jL16OPYtj[C3|!JNLTN#9&PjJxU' );
define( 'SECURE_AUTH_KEY',   'nCYGE3%}l!`_In``kUNJbVseyv>%~{yKzQTh`@~7DcbB! ,5!wRWGPK]aIIHKy Y' );
define( 'LOGGED_IN_KEY',     'V[Veu+?8^cfr8$_~03E7;-W${QEyiH08|TZ,7[qP%To>A@SR (z-$PSe|;HdrR,}' );
define( 'NONCE_KEY',         'L>Ava3yN.6UB2BC]A?l9* .(SukWg3zIy 9P 4tU^xV3(O(x7DDg{XUjEw$14 cH' );
define( 'AUTH_SALT',         'WH3pkOtOfE$V({uhD2d`NW>T710/q.8=zvRF/^Nb*@yyj?@:`Ed3i9F2[W9g.@NY' );
define( 'SECURE_AUTH_SALT',  'Cg0R T2(z&Gp})mU}BjL=NkW,*I8(oxTd6`%!KUYID,]3(J@.=Nrgv5/}sFHJ6kp' );
define( 'LOGGED_IN_SALT',    '{&0L:[gQJ3,AV?Qk&w/VKKOk)q;>!nXN#8 |cnS$Qpd%mhsQ&Z1IO^~Bd/t5Rb-&' );
define( 'NONCE_SALT',        'Vm[5cX}}cvu(D.tue/L#b)nX/7,R#yuDSz|JJ,zpr1$E!j|HK6I9[m}^hO[kHE~>' );
define( 'WP_CACHE_KEY_SALT', 'g$:-swP~OYjaS)*$ZBBb*gp9j~kGL8_IeoQAj0y|ZN?`$&uR%~5fg:h^__B t?KX' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
