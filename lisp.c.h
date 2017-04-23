/* Generated by           cobc 2.0.0 */
/* Generated from         lisp.cbl */
/* Generated at           Apr 22 2017 20:52:42 */
/* GnuCOBOL build date    Nov 13 2016 01:30:50 */
/* GnuCOBOL package date  Nov 06 2016 22:36:19 UTC */
/* Compile command        cobc.exe -o bin\lisp.dll -std=default -Wall -debug -g -LC:\Users\laury\Documents\Computer School\Recurse Center\Cisp\subroutines\bin -L\subroutines\bin -L..\subroutines\bin lisp.cbl */


/* Module path */
static const char		*cob_module_path = NULL;

/* Number of call parameters */
static int		cob_call_params = 0;

/* Attributes */

static const cob_field_attr a_1 =	{0x10,   1,   0, 0x0000, NULL};
static const cob_field_attr a_2 =	{0x21,   0,   0, 0x0000, NULL};
static const cob_field_attr a_3 =	{0x10,   4,   0, 0x0000, NULL};
static const cob_field_attr a_4 =	{0x01,   0,   0, 0x0000, NULL};
static const cob_field_attr a_5 =	{0x10,  10,   0, 0x0000, NULL};
static const cob_field_attr a_6 =	{0x10,  20,   0, 0x0000, NULL};

static const cob_field_attr cob_all_attr = {0x22, 0, 0, 0, NULL};


/* Constants */
static const cob_field c_1	= {1, (cob_u8_ptr)"(", &a_2};
static const cob_field c_2	= {1, (cob_u8_ptr)")", &a_2};
static const cob_field c_3	= {4, (cob_u8_ptr)"INIT", &a_2};
static const cob_field c_4	= {8, (cob_u8_ptr)"IS-EMPTY", &a_2};
static const cob_field c_5	= {11, (cob_u8_ptr)"STACK-EMPTY", &a_2};
static const cob_field c_6	= {14, (cob_u8_ptr)"POP-CALL-STACK", &a_2};
static const cob_field c_7	= {5, (cob_u8_ptr)"CLOSE", &a_2};
static const cob_field c_8	= {4, (cob_u8_ptr)"LISP", &a_2};
static const cob_field c_9	= {8, (cob_u8_ptr)"Command:", &a_2};
static const cob_field c_10	= {5, (cob_u8_ptr)"write", &a_2};
static const cob_field c_11	= {1, (cob_u8_ptr)"+", &a_2};
static const cob_field c_12	= {5, (cob_u8_ptr)"LISP:", &a_2};
static const cob_field c_13	= {7, (cob_u8_ptr)"Result:", &a_2};

static cob_field cob_all_space	= {1, (cob_u8_ptr)" ", &cob_all_attr};


/* Strings */
static const char st_1[]	= "lisp.cbl";
static const char st_2[]	= "Entry:     LISP";
static const char st_3[]	= "Section:   (None)";
static const char st_4[]	= "Paragraph: MAIN-PROCEDURE";
static const char st_5[]	= "MAIN-PROCEDURE";
static const char st_6[]	= "PERFORM";
static const char st_7[]	= "EVALUATE";
static const char st_8[]	= "SET";
static const char st_9[]	= "MOVE";
static const char st_10[]	= "IF";
static const char st_11[]	= "GOBACK";
static const char st_12[]	= "Paragraph: INIT-CALL-STACK-PROCEDURE";
static const char st_13[]	= "INIT-CALL-STACK-PROCEDURE";
static const char st_14[]	= "CALL";
static const char st_15[]	= "Paragraph: INIT-RECURSION-OBJECT-PROCEDURE";
static const char st_16[]	= "INIT-RECURSION-OBJECT-PROCEDURE";
static const char st_17[]	= "Paragraph: RETURN-PROCEDURE";
static const char st_18[]	= "RETURN-PROCEDURE";
static const char st_19[]	= "Paragraph: POP-CALL-STACK";
static const char st_20[]	= "POP-CALL-STACK";
static const char st_21[]	= "Paragraph: CLOSE-CALL-STACK-PROCEDURE";
static const char st_22[]	= "CLOSE-CALL-STACK-PROCEDURE";
static const char st_23[]	= "Paragraph: LOG-CURRENT-COMMAND-PROCEDURE";
static const char st_24[]	= "LOG-CURRENT-COMMAND-PROCEDURE";
static const char st_25[]	= "STRING";
static const char st_26[]	= "Paragraph: EVALUATE-CURRENT-COMMAND";
static const char st_27[]	= "EVALUATE-CURRENT-COMMAND";
static const char st_28[]	= "Paragraph: APPLY-VALUE-TO-EXPRESSION";
static const char st_29[]	= "APPLY-VALUE-TO-EXPRESSION";
static const char st_30[]	= "Paragraph: LISP-WRITE-PROCEDURE";
static const char st_31[]	= "LISP-WRITE-PROCEDURE";
static const char st_32[]	= "DISPLAY";
static const char st_33[]	= "Paragraph: LISP-ADD-PROCEDURE";
static const char st_34[]	= "LISP-ADD-PROCEDURE";
static const char st_35[]	= "ADD";
static const char st_36[]	= "Paragraph: LOG-COMMAND-EVALUTATION";
static const char st_37[]	= "LOG-COMMAND-EVALUTATION";
static const char st_38[]	= "Exit:      LISP";

static int COB_NOINLINE
cob_get_numdisp (const void *data, const size_t size)
{
	const unsigned char	*p;
	size_t			n;
	int    			 retval;
	p = (const unsigned char *)data;
	retval = 0;
	for (n = 0; n < size; ++n, ++p) {
		retval *= 10;
		retval += (*p & 0x0F);
	}
	return retval;
}

