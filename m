Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89651ECAAD5
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 20:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIEUna (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEUn2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 16:43:28 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A749465645
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 13:43:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35A7A1BF207;
        Mon,  5 Sep 2022 20:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662410601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dmr/bzmt973yT9b+06KOqqMsSYwtvcJBhkOV+yohms=;
        b=k+0cvhzpfbn/0Qfl6zdZCY2uW/NJUMcc4QWNVLtRiYkcLoiOI2ZAxot4dbqUjXi9Y5yFwR
        brq/KDVC4o8RbMCDOElpKSqUbiky0vrsyUuv1LKYknzxRZJWTnHYCi1rCRK7/Opyzgu92B
        TAEhKSgUqa2j+1rWonCUulabRxI0pmz6ZxL6+ja+HT4WoIX5pzoerGw0RFRMAJ7341V6cs
        5jvyuNCqJunBc07oz9DxreffaEI3IFvvTGVnxg1Tc4IY9jKU8RotHjUDUkX3qRb+x2wmRO
        Au+EQ7Ey9/PW0b5qaL1zbmZXvG5KKQE7gy8WkAkGA8oFeXHhHENzPtpGGpOD9Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     werner@almesberger.net
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <aahringo@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH atusb/fw 2/2] atusb: fw: Provide TRAC status
Date:   Mon,  5 Sep 2022 22:43:18 +0200
Message-Id: <20220905204318.1324284-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
References: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

Upon Tx done condition, returning the sequence number is useful but we
might also return the TRAC value which is needed to ensure that the
packet we sent got ACKed. The TRAC register just needs to be read when
the TRX_END interrupt fires.

We then need to send this information as part of the status
message. First byte remains the sequence number for ensuring backward
compatibility and a second byte is added to forward the TRAC register
status.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
[Miquel Raynal: Moved the data array out of the stack, wrote commit log]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 atusb/fw/.version      |   1 +
 atusb/fw/app-atu2.d    |   8 ++
 atusb/fw/atusb.bin     | Bin 0 -> 6536 bytes
 atusb/fw/atusb.d       |  13 +++
 atusb/fw/atusb.dfu     | Bin 0 -> 6552 bytes
 atusb/fw/atusb.elf     | Bin 0 -> 52324 bytes
 atusb/fw/board.d       |  12 ++
 atusb/fw/board_app.d   |  13 +++
 atusb/fw/board_atusb.d |  13 +++
 atusb/fw/boot-atu2.d   |   8 ++
 atusb/fw/boot.d        |  14 +++
 atusb/fw/boot.elf      | Bin 0 -> 36816 bytes
 atusb/fw/boot.hex      | 259 +++++++++++++++++++++++++++++++++++++++++
 atusb/fw/descr.d       |  12 ++
 atusb/fw/dfu.d         |  11 ++
 atusb/fw/dfu_common.d  |  13 +++
 atusb/fw/ep0.d         |  20 ++++
 atusb/fw/flash.d       |  11 ++
 atusb/fw/mac.c         |  13 ++-
 atusb/fw/mac.d         |  13 +++
 atusb/fw/sernum.d      |  11 ++
 atusb/fw/spi.d         |   8 ++
 atusb/fw/usb.d         |   8 ++
 atusb/fw/version.c     |   4 +
 atusb/fw/version.d     |   5 +
 25 files changed, 466 insertions(+), 4 deletions(-)
 create mode 100644 atusb/fw/.version
 create mode 100644 atusb/fw/app-atu2.d
 create mode 100755 atusb/fw/atusb.bin
 create mode 100644 atusb/fw/atusb.d
 create mode 100755 atusb/fw/atusb.dfu
 create mode 100755 atusb/fw/atusb.elf
 create mode 100644 atusb/fw/board.d
 create mode 100644 atusb/fw/board_app.d
 create mode 100644 atusb/fw/board_atusb.d
 create mode 100644 atusb/fw/boot-atu2.d
 create mode 100644 atusb/fw/boot.d
 create mode 100755 atusb/fw/boot.elf
 create mode 100644 atusb/fw/boot.hex
 create mode 100644 atusb/fw/descr.d
 create mode 100644 atusb/fw/dfu.d
 create mode 100644 atusb/fw/dfu_common.d
 create mode 100644 atusb/fw/ep0.d
 create mode 100644 atusb/fw/flash.d
 create mode 100644 atusb/fw/mac.d
 create mode 100644 atusb/fw/sernum.d
 create mode 100644 atusb/fw/spi.d
 create mode 100644 atusb/fw/usb.d
 create mode 100644 atusb/fw/version.c
 create mode 100644 atusb/fw/version.d

diff --git a/atusb/fw/.version b/atusb/fw/.version
new file mode 100644
index 0000000..6f4247a
--- /dev/null
+++ b/atusb/fw/.version
@@ -0,0 +1 @@
+26
diff --git a/atusb/fw/app-atu2.d b/atusb/fw/app-atu2.d
new file mode 100644
index 0000000..6a248fd
--- /dev/null
+++ b/atusb/fw/app-atu2.d
@@ -0,0 +1,8 @@
+app-atu2.o: usb/atu2.c usb/usb.h board.h include/atusb/atusb.h board_atusb=
.h
+
+usb/atu2.c:
+usb/usb.h:
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+
diff --git a/atusb/fw/atusb.bin b/atusb/fw/atusb.bin
new file mode 100755
index 0000000000000000000000000000000000000000..5f3c76c20b9a71076a3c5b5dd27=
254d50e143fa7
GIT binary patch
literal 6536
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

literal 0
HcmV?d00001

diff --git a/atusb/fw/atusb.d b/atusb/fw/atusb.d
new file mode 100644
index 0000000..8ccacd3
--- /dev/null
+++ b/atusb/fw/atusb.d
@@ -0,0 +1,13 @@
+atusb.o: atusb.c usb/usb.h board.h include/atusb/atusb.h board_atusb.h \
+ sernum.h spi.h include/atusb/ep0.h
+
+atusb.c:
+usb/usb.h:
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+
+sernum.h:
+spi.h:
+include/atusb/ep0.h:
+
diff --git a/atusb/fw/atusb.dfu b/atusb/fw/atusb.dfu
new file mode 100755
index 0000000000000000000000000000000000000000..77e203029cac8a291de0377dc6b=
a5333e47f9877
GIT binary patch
literal 6552
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

literal 0
HcmV?d00001

diff --git a/atusb/fw/atusb.elf b/atusb/fw/atusb.elf
new file mode 100755
index 0000000000000000000000000000000000000000..ac18ae42dcc789b79c904d18670=
114beaf2cecf1
GIT binary patch
literal 52324
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

literal 0
HcmV?d00001

diff --git a/atusb/fw/board.d b/atusb/fw/board.d
new file mode 100644
index 0000000..aa2f13f
--- /dev/null
+++ b/atusb/fw/board.d
@@ -0,0 +1,12 @@
+board.o: board.c usb/usb.h include/at86rf230.h board.h \
+ include/atusb/atusb.h board_atusb.h spi.h
+
+board.c:
+usb/usb.h:
+include/at86rf230.h:
+board.h:
+
+include/atusb/atusb.h:
+board_atusb.h:
+spi.h:
+
diff --git a/atusb/fw/board_app.d b/atusb/fw/board_app.d
new file mode 100644
index 0000000..c1659bc
--- /dev/null
+++ b/atusb/fw/board_app.d
@@ -0,0 +1,13 @@
+board_app.o: board_app.c usb/usb.h include/at86rf230.h spi.h mac.h \
+ board.h include/atusb/atusb.h board_atusb.h
+
+board_app.c:
+usb/usb.h:
+include/at86rf230.h:
+spi.h:
+mac.h:
+
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+
diff --git a/atusb/fw/board_atusb.d b/atusb/fw/board_atusb.d
new file mode 100644
index 0000000..7ab1254
--- /dev/null
+++ b/atusb/fw/board_atusb.d
@@ -0,0 +1,13 @@
+board_atusb.o: board_atusb.c usb/usb.h include/at86rf230.h board.h \
+ include/atusb/atusb.h board_atusb.h spi.h usb/usb.h
+
+board_atusb.c:
+usb/usb.h:
+include/at86rf230.h:
+board.h:
+
+include/atusb/atusb.h:
+board_atusb.h:
+spi.h:
+usb/usb.h:
+
diff --git a/atusb/fw/boot-atu2.d b/atusb/fw/boot-atu2.d
new file mode 100644
index 0000000..ed90f78
--- /dev/null
+++ b/atusb/fw/boot-atu2.d
@@ -0,0 +1,8 @@
+boot-atu2.o: usb/atu2.c usb/usb.h board.h include/atusb/atusb.h board_atus=
b.h
+
+usb/atu2.c:
+usb/usb.h:
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+
diff --git a/atusb/fw/boot.d b/atusb/fw/boot.d
new file mode 100644
index 0000000..23c9a7f
--- /dev/null
+++ b/atusb/fw/boot.d
@@ -0,0 +1,14 @@
+boot.o: boot.c usb/usb.h usb/dfu.h usb/usb.h board.h \
+ include/atusb/atusb.h board_atusb.h spi.h include/atusb/ep0.h
+
+boot.c:
+usb/usb.h:
+usb/dfu.h:
+usb/usb.h:
+board.h:
+
+include/atusb/atusb.h:
+board_atusb.h:
+spi.h:
+include/atusb/ep0.h:
+
diff --git a/atusb/fw/boot.elf b/atusb/fw/boot.elf
new file mode 100755
index 0000000000000000000000000000000000000000..ebf39f512d97d832b7c8076a06c=
0d5b08d02b1fd
GIT binary patch
literal 36816
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
IuUq>5C+-q^GXMYp

literal 0
HcmV?d00001

diff --git a/atusb/fw/boot.hex b/atusb/fw/boot.hex
new file mode 100644
index 0000000..10fa523
--- /dev/null
+++ b/atusb/fw/boot.hex
@@ -0,0 +1,259 @@
+:107000000C944C380C9469380C9469380C94693899=0D
+:107010000C9469380C9469380C9469380C9469386C=0D
+:107020000C9469380C9469380C9469380C94DB3DE5=0D
+:107030000C940D3E0C9469380C9469380C946938A2=0D
+:107040000C9469380C9469380C9469380C9469383C=0D
+:107050000C9469380C9469380C9469380C9469382C=0D
+:107060000C9469380C9469380C9469380C9469381C=0D
+:107070000C9469380C9469380C9469380C9469380C=0D
+:107080000C9469380C9469380C9469380C946938FC=0D
+:107090000C9469380C94693811241FBECFEFD4E0EA=0D
+:1070A000DEBFCDBF11E0A0E0B1E0E6E9FFE702C03E=0D
+:1070B00005900D92A037B107D9F711E0A0E7B1E034=0D
+:1070C00001C01D92AE3CB107E1F70E946B380C94F1=0D
+:1070D000C93F0C940038DF93CF9300D0CDB7DEB713=0D
+:1070E0001A8219820E944C3F0E94AB380E94893F4D=0D
+:1070F0000E948D3B81E085BF82E085BF789481E06E=0D
+:107100000E94C1382091620180E090E0A0E0B0E0F0=0D
+:107110000FC080E090E0A0E0B0E002C02230D1F4E7=0D
+:10712000E981FA81E491EF3FA1F30196A11DB11D20=0D
+:107130008C3737EC93073CE0A30730E0B30771F7D7=0D
+:1071400080E00E94C138F8940E94423FE0E0F0E005=0D
+:107150000995FFCFFFCF14B817B81AB815B818B8EB=0D
+:107160001BB8269A3F9A249A0E94613F479885E06F=0D
+:10717000982F9A95F1F7479A8A95F1F70E947E3FEA=0D
+:107180000895882311F02E9A08952E980895F89462=0D
+:1071900028EC30E02E9A88EE93E0F9013197F1F770=0D
+:1071A0000197D9F72E9888EE93E0F9013197F1F71E=0D
+:1071B0000197D9F7EFCF80E090E041E2FC013E96E5=0D
+:1071C00040935700E4919C01220F331F220F331F7D=0D
+:1071D000D90112965E2F52955F705A3010F4505DAF=0D
+:1071E00001C0595AA050BF4F5C932C5F3F4FEF70C6=0D
+:1071F000EA3010F4E05D01C0E95AD901A050BF4F58=0D
+:10720000EC9301968A309105C9F60895FA01D901E7=0D
+:10721000833099F4662319F0613089F406C08AE25C=0D
+:1072200091E09183808384E005C080E091E09183C8=0D
+:1072300080838AE28C9381E0089580E0089580E065=0D
+:1072400008958093CE008091C80087FFFCCF809185=0D
+:10725000CE000895599A08956623D9F01092CE0071=0D
+:10726000262FFC0109C03091C80037FFFCCF3091B8=0D
+:10727000CE0031931092CE002150A9F76150860FB5=0D
+:10728000911D2091C80027FFFCCF2091CE00FC016A=0D
+:107290002083089510927001109271011092720172=0D
+:1072A0001092730108959C0140E050E080917001BC=0D
+:1072B00090917101A0917201B0917301280F391F53=0D
+:1072C0004A1F5B1F81E0213090E7390790E04907B2=0D
+:1072D00090E0590708F080E008952F923F924F9276=0D
+:1072E0005F926F927F928F929F92AF92BF92CF9256=0D
+:1072F000DF92EF92FF920F931F93CF93DF93EB01F7=0D
+:10730000A0907001B0907101C0907201D090730193=0D
+:1073100090907401860175010894E11CF11C011D17=0D
+:10732000111DA6019501DC013C01660E771E93E05C=0D
+:10733000892E5524539485E0482E44C0CA01B901D2=0D
+:107340006F7770708070907061157105810591057F=0D
+:1073500039F4F90180925700E89507B600FCFDCF9B=0D
+:10736000C901817090706C91009769F0892D90E04F=0D
+:10737000362E222482299329F9010C0150925700BC=0D
+:10738000E895112401C0962EC801B7016F7770707F=0D
+:1073900080709070611571058105910549F4F701C0=0D
+:1073A000E058F04040925700E89507B600FCFDCF4A=0D
+:1073B00011960894E11CF11C011D111D2F5F3F4F18=0D
+:1073C0004F4F5F4FA615B70509F0B8CFCE01A0E02B=0D
+:1073D000B0E08A0D9B1DAC1DBD1D80937001909384=0D
+:1073E0007101A0937201B093730190927401DF91C7=0D
+:1073F000CF911F910F91FF90EF90DF90CF90BF90B2=0D
+:10740000AF909F908F907F906F905F904F903F9044=0D
+:107410002F9008958091700190917101A091720157=0D
+:10742000B09173019C01AD012F77307040705070A6=0D
+:10743000211531054105510549F0807825E0FC0111=0D
+:1074400020935700E89507B600FCFDCF81E18093BB=0D
+:107450005700E8950895EF92FF920F931F93CF93F3=0D
+:10746000DF93DC01E0907001F090710100917201F6=0D
+:1074700010917301A801970108C0E491ED93615048=0D
+:1074800070402F5F3F4F4F4F5F4FF901E901CE1919=0D
+:10749000DF096115710541F0203080E8380780E090=0D
+:1074A000480780E0580749F7209370013093710135=0D
+:1074B0004093720150937301CE01DF91CF911F91E0=0D
+:1074C0000F91FF90EF900895E0912E01F0912F0120=0D
+:1074D000DC016D917C910480F581E02D88E791E0DD=0D
+:1074E000099508950895EF92FF920F931F93CF93FC=0D
+:1074F000DF93EC01398120E0888190E0822B932B8F=0D
+:1075000021E081329207A1F0E1E082329E072CF463=0D
+:107510008132910509F0F3C0F6C0F2E0813A9F078D=0D
+:1075200009F47CC026E08132920709F0E8C0E1C08E=0D
+:1075300080916201823079F48A819B8190937601F7=0D
+:1075400080937501E0912E01F0912F010190F0815F=0D
+:10755000E02D099503C0853009F0D7C08091620104=0D
+:10756000823059F0809175019091760101972A81BE=0D
+:107570003B812817390709F4C6C02A813B818091D5=0D
+:107580007501909176012817390709F074C00E80B3=0D
+:10759000DF81C02DE0912E01F0912F01209759F449=0D
+:1075A0000680F781E02D099582E08093620181E0F9=0D
+:1075B00080937701ABC00280F381E02DCE01099565=0D
+:1075C000882311F488E004C0C134D10528F08EE08E=0D
+:1075D00080935E0180E014C0D093B901C093B801DC=0D
+:1075E00083EC91E061E070E048E751E02C2F04E685=0D
+:1075F0001AE338EBE32E31E0F32E0E94E93B81E001=0D
+:1076000020917501309176012F5F3F4F30937601C5=0D
+:107610002093750195E09093620178C0809162019A=0D
+:10762000823079F48A819B819093760180937501F1=0D
+:10763000E0912E01F0912F010190F081E02D09954C=0D
+:1076400003C0893009F061C080916201823051F03D=0D
+:10765000809175019091760101972A813B812817CD=0D
+:10766000390749F02A813B8180917501909176011B=0D
+:107670002817390739F08AE0809362018EE0809301=0D
+:107680005E0141C00E80DF81C02DC134D10520F0E4=0D
+:107690008EE080935E0120C0E0912E01F0912F01D9=0D
+:1076A0000084F185E02D88E791E0BE0109959C01F9=0D
+:1076B0008C179D0720F482E08093620101C09E0137=0D
+:1076C00083EC91E062E070E048E751E000E010E018=0D
+:1076D000EE24FF240E94E93B809175019091760190=0D
+:1076E0000196909376018093750189E08093620101=0D
+:1076F0000AC082E08093620110925E0104C0CE0154=0D
+:107700000E94A03B03C081E001C080E0DF91CF91E7=0D
+:107710001F910F91FF90EF90089583E79AE3909364=0D
+:10772000C2018093C1018AED9BE39093BC018093D9=0D
+:10773000BB0182E79AE39093BE018093BD01089557=0D
+:10774000EF92FF920F931F93FC01318120E0808123=0D
+:1077500090E0822B932B24E08132920781F025E088=0D
+:10776000813A920791F023E0813A9207E9F483ECA1=0D
+:1077700091E062E070E04EE551E026E00DC082E06D=0D
+:107780008093620110925E010DC083EC91E062E093=0D
+:1077900070E042E651E021E000E010E0EE24FF243A=0D
+:1077A0000E94E93B81E001C080E01F910F91FF90B2=0D
+:1077B000EF900895813219F00E940639089584E609=0D
+:1077C00091E0FA019183808389E0F901808381E06F=0D
+:1077D00008958F929F92AF92BF92CF92DF92EF92D5=0D
+:1077E000FF920F931F93DF93CF930F92CDB7DEB726=0D
+:1077F0004C015B016A01FC0180819181009721F0BD=0D
+:1078000029830E94C7382981F401B182A082D382E2=0D
+:10781000C282C20ED11CD582C48210870783F28631=0D
+:10782000E186C4010E94A93D0F90CF91DF911F9185=0D
+:107830000F91FF90EF90DF90CF90BF90AF909F900F=0D
+:107840008F900895FF920F931F93DF93CF9300D0F3=0D
+:107850000F92CDB7DEB7DC0111969C91119780E0B5=0D
+:107860002C9130E0282B392B85E02030380709F4A3=0D
+:1078700081C085E02130380714F581E020303807D9=0D
+:1078800009F42EC181E0213038076CF4203831052D=0D
+:1078900009F451C0203831050CF419C123383105E1=0D
+:1078A0000CF015C11FC181E0233038070CF41AC158=0D
+:1078B000205033402330310508F009C113C188E05E=0D
+:1078C0002038380709F4ABC088E02138380784F441=0D
+:1078D00086E0203838070CF4FAC086E022383807F2=0D
+:1078E0000CF44DC087E02030380709F0F0C0FAC032=0D
+:1078F0008AE02138380709F4F5C08AE022383807D1=0D
+:1079000034F489E02030380709F0E1C0AFC08BE0E3=0D
+:107910002130380731F08CE02238380709F0D7C021=0D
+:10792000E1C020914E0130E0245B3E4F80E090E0CA=0D
+:10793000E5E5F1E0C8C016968D919C9117978230CD=0D
+:10794000910509F0CFC00DE611E08091C30190913F=0D
+:10795000C401009711F00E94C73882E090E0909334=0D
+:10796000C4018093C3011093C6010093C5010E5F4B=0D
+:107970001F4F6BC012968C910E94913DB1C0129620=0D
+:107980006C91129713968C91139716960D911C91EA=0D
+:107990001797813019F0823099F407C08AE391E09B=0D
+:1079A0009B838A8380913A0109C0662309F09AC0BB=0D
+:1079B0008CE491E09B838A8380914E01898311C07E=0D
+:1079C000E091BB01F091BC01309709F48BC0AE018E=0D
+:1079D0004E5F5F4F9E012F5F3F4F0995882309F44B=0D
+:1079E00081C0898190E00817190708F409830A818A=0D
+:1079F0001B81F9808091C3019091C401009711F01F=0D
+:107A00000E94C73882E090E09093C4018093C30144=0D
+:107A10001093C6010093C5010F0D111D16C00FE68E=0D
+:107A200011E08091C3019091C401009711F00E9470=0D
+:107A3000C73882E090E09093C4018093C301109313=0D
+:107A4000C6010093C5010F5F1F4F1093C80100933B=0D
+:107A5000C7011092CB011092CA011092CD01109271=0D
+:107A6000CC0183EC91E00E94A93D3AC020915101E4=0D
+:107A700030E081E012964D915C91139742175307C5=0D
+:107A800089F531C041814430D9F4628170E01496A7=0D
+:107A90004D915C9115976417750789F4638170E0C7=0D
+:107AA00012964D915C9113976417750741F4E0911C=0D
+:107AB000BF01F091C001309799F0099511C001966E=0D
+:107AC0004081E40FF11DE217F307E1F60BC0E091EE=0D
+:107AD000C101F091C201309729F0CD01099503C091=0D
+:107AE00081E001C080E00F900F900F90CF91DF9167=0D
+:107AF0001F910F91FF900895E1EFF0E02081308118=0D
+:107B0000932F80E030E0282B392BC9010895809114=0D
+:107B1000E80080FFFCCF8091E30080688093E30061=0D
+:107B20000895EF92FF920F931F938093E30083ECED=0D
+:107B300091E062E070E040E050E020E007E81DE303=0D
+:107B4000EE24FF240E94E93B1F910F91FF90EF90DC=0D
+:107B50000895FC01208131812230310569F4835C74=0D
+:107B6000914063EA7BE80E94B73F8093E9008091EF=0D
+:107B7000F00081608093F00008951092E90089E0A0=0D
+:107B80008093EB001092EC0080E38093ED008091F5=0D
+:107B9000ED0082608093ED008091EE0087FFFCCFC6=0D
+:107BA0008FE08093F0001092C4011092C30180E432=0D
+:107BB0008093C90108951F920F920FB60F9211245E=0D
+:107BC0002F933F934F935F936F937F938F939F93E5=0D
+:107BD000AF93BF93EF93FF938091E10083FF0CC0BD=0D
+:107BE000E091BD01F091BE01309709F009950E9426=0D
+:107BF000BD3D87EF8093E100FF91EF91BF91AF9181=0D
+:107C00009F918F917F916F915F914F913F912F91B4=0D
+:107C10000F900FBE0F901F9018951F920F920FB6E6=0D
+:107C20000F921124EF92FF920F931F932F933F9384=0D
+:107C30004F935F936F937F938F939F93AF93BF9374=0D
+:107C4000EF93FF93DF93CF93CDB7DEB72897DEBFD7=0D
+:107C5000CDBF8091F40080FFFBC01092E9008091BD=0D
+:107C6000E80083FF3BC01092C4011092C3018091D1=0D
+:107C7000F200883010F40E94C7388091F1008983A7=0D
+:107C80008091F1008A830E947C3D9C838B830E94BB=0D
+:107C90007C3D9E838D830E947C3D98878F83CE019F=0D
+:107CA00001960E94223C882309F4BDC0898187FD8A=0D
+:107CB000C7C08091C3019091C401009709F0C0C072=0D
+:107CC00083EC91E062E070E040E050E020E000E012=0D
+:107CD00010E0EE24FF240E94E93BB2C08091E8004E=0D
+:107CE00082FF4EC08091C3019091C4018130910503=0D
+:107CF00009F099C06091F200262F30E08091C70111=0D
+:107D00009091C8014091C5015091C601841B950B0B=0D
+:107D1000821793070CF487C008C08091F10081930B=0D
+:107D2000F093C601E093C5016150E091C501F09167=0D
+:107D3000C601662391F78091C7019091C801E817A9=0D
+:107D4000F90709F081C01092C4011092C301E091BB=0D
+:107D5000CA01F091CB01309729F08091CC0190912C=0D
+:107D6000CD01099583EC91E062E070E040E050E0E5=0D
+:107D700020E000E010E0EE24FF240E94E93B64C014=0D
+:107D80008091E80081FF07C01092C4011092C301E6=0D
+:107D90008DEF8093E8008091E80080FF59C08091CA=0D
+:107DA000C3019091C40182309105B9F58091C7015A=0D
+:107DB0002091C5019091C901821B981708F4892F61=0D
+:107DC000982F0CC0E091C501F091C601219120933C=0D
+:107DD000F100F093C601E093C5019150992391F70A=0D
+:107DE0009091C901891721F01092C4011092C3012A=0D
+:107DF0008EEF8093E8008091C3019091C4010097B9=0D
+:107E000039F5E091CA01F091CB01309709F18091E9=0D
+:107E1000CC019091CD0109951BC08091F0008E7F1F=0D
+:107E20008093F00015C081EF8093E8001092C401A8=0D
+:107E30001092C3018091EB0080628093EB0008C038=0D
+:107E400087EF8093E8004ACF8BE78093E80098CFD4=0D
+:107E50002896DEBFCDBFCF91DF91FF91EF91BF910B=0D
+:107E6000AF919F918F917F916F915F914F913F91D2=0D
+:107E70002F911F910F91FF90EF900F900FBE0F90D9=0D
+:107E80001F901895E0EEF0E080818160808380EDA6=0D
+:107E900097E00197F1F7089514BEE0E6F0E08081E5=0D
+:107EA0008061808380E18083E1E6F0E080E8808388=0D
+:107EB00010820E94DB3808951092BA011092C90016=0D
+:107EC0000895599A559A539A519A5298ECECF0E0C9=0D
+:107ED0001182108280EC8093CA0088E18093C900EF=0D
+:107EE0001182108281E08093BA0108958091BA01D5=0D
+:107EF000882311F40E94613F599808950E94763FAB=0D
+:107F000083EC0E94213984E00E9421390E942A39A1=0D
+:107F100008958091D80080628093D80089B5837ECF=0D
+:107F200089BD89B5826089BD09B400FEFDCF80910D=0D
+:107F3000D8008F778093D8008091D8008068809394=0D
+:107F4000D8008091D8008F7D8093D8008091E00088=0D
+:107F50008E7F8093E00088E08093E2000E94BD3D28=0D
+:107F6000089583E08093690081E08DBB08955527D3=0D
+:107F7000002480FF02C0060E571F660F771F611591=0D
+:107F8000710521F096958795009799F7952F802D8B=0D
+:067F90000895F894FFCFF4=0D
+:107F96002A030000000000000000000000000000AE=0D
+:107FA60000000000000000000000000000000000CB=0D
+:107FB6000000000000000000000004030904300176=0D
+:107FC6004A3953396D390A3A2B3A12010001FE003B=0D
+:107FD6000040B7204015010000000101090212000F=0D
+:107FE60001010080140904000000FE010200006483=0D
+:107FF6000000020009210FFFFF4000010100000000=0D
+:040000030000700089=0D
+:00000001FF=0D
diff --git a/atusb/fw/descr.d b/atusb/fw/descr.d
new file mode 100644
index 0000000..cccf24c
--- /dev/null
+++ b/atusb/fw/descr.d
@@ -0,0 +1,12 @@
+descr.o: descr.c usb/usb.h usb/dfu.h usb/usb.h board.h \
+ include/atusb/atusb.h board_atusb.h
+
+descr.c:
+usb/usb.h:
+usb/dfu.h:
+usb/usb.h:
+board.h:
+
+include/atusb/atusb.h:
+board_atusb.h:
+
diff --git a/atusb/fw/dfu.d b/atusb/fw/dfu.d
new file mode 100644
index 0000000..6e0954e
--- /dev/null
+++ b/atusb/fw/dfu.d
@@ -0,0 +1,11 @@
+dfu.o: usb/dfu.c usb/usb.h usb/dfu.h board.h include/atusb/atusb.h \
+ board_atusb.h
+
+usb/dfu.c:
+usb/usb.h:
+usb/dfu.h:
+board.h:
+include/atusb/atusb.h:
+
+board_atusb.h:
+
diff --git a/atusb/fw/dfu_common.d b/atusb/fw/dfu_common.d
new file mode 100644
index 0000000..b3d986f
--- /dev/null
+++ b/atusb/fw/dfu_common.d
@@ -0,0 +1,13 @@
+dfu_common.o: usb/dfu_common.c usb/usb.h usb/dfu.h board.h \
+ include/atusb/atusb.h board_atusb.h usb/../sernum.h usb/../board.h
+
+usb/dfu_common.c:
+usb/usb.h:
+usb/dfu.h:
+board.h:
+
+include/atusb/atusb.h:
+board_atusb.h:
+usb/../sernum.h:
+usb/../board.h:
+
diff --git a/atusb/fw/ep0.d b/atusb/fw/ep0.d
new file mode 100644
index 0000000..3c719ec
--- /dev/null
+++ b/atusb/fw/ep0.d
@@ -0,0 +1,20 @@
+ep0.o: ep0.c usb/usb.h usb/dfu.h usb/usb.h include/at86rf230.h \
+ include/atusb/ep0.h include/atusb/atusb.h version.h board.h \
+ board_atusb.h sernum.h spi.h mac.h
+
+ep0.c:
+usb/usb.h:
+usb/dfu.h:
+usb/usb.h:
+include/at86rf230.h:
+
+include/atusb/ep0.h:
+include/atusb/atusb.h:
+version.h:
+board.h:
+
+board_atusb.h:
+sernum.h:
+spi.h:
+mac.h:
+
diff --git a/atusb/fw/flash.d b/atusb/fw/flash.d
new file mode 100644
index 0000000..d8e5a90
--- /dev/null
+++ b/atusb/fw/flash.d
@@ -0,0 +1,11 @@
+flash.o: flash.c usb/dfu.h usb/usb.h board.h include/atusb/atusb.h \
+ board_atusb.h
+
+flash.c:
+usb/dfu.h:
+usb/usb.h:
+board.h:
+include/atusb/atusb.h:
+
+board_atusb.h:
+
diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 835002c..a520887 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -32,8 +32,8 @@ static uint8_t tx_buf[MAX_PSDU];
 static uint8_t tx_size =3D 0;
 static bool txing =3D 0;
 static bool queued_tx_ack =3D 0;
-static uint8_t next_seq, this_seq, queued_seq;
-
+static uint8_t next_seq, this_seq, queued_seq, queued_tx_trac;
+static uint8_t data[2];
=20
 /* ----- Receive buffer management ---------------------------------------=
-- */
=20
@@ -65,7 +65,9 @@ static void usb_next(void)
 	}
=20
 	if (queued_tx_ack) {
-		usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
+		data[0] =3D queued_seq;
+		data[1] =3D reg_read(REG_TRX_STATE);
+		usb_send(&eps[1], data, 2, tx_ack_done, NULL);
 		queued_tx_ack =3D 0;=09
 	}
 }
@@ -124,10 +126,13 @@ static bool handle_irq(void)
=20
 	if (txing) {
 		if (eps[1].state =3D=3D EP_IDLE) {
-			usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
+			data[0] =3D this_seq;
+			data[1] =3D reg_read(REG_TRX_STATE);
+			usb_send(&eps[1], data, 2, tx_ack_done, NULL);
 		} else {
 			queued_tx_ack =3D 1;
 			queued_seq =3D this_seq;
+			queued_tx_trac =3D reg_read(REG_TRX_STATE);
 		}
 		txing =3D 0;
 		return 1;
diff --git a/atusb/fw/mac.d b/atusb/fw/mac.d
new file mode 100644
index 0000000..aa43423
--- /dev/null
+++ b/atusb/fw/mac.d
@@ -0,0 +1,13 @@
+mac.o: mac.c usb/usb.h include/at86rf230.h spi.h board.h \
+ include/atusb/atusb.h board_atusb.h mac.h
+
+mac.c:
+usb/usb.h:
+include/at86rf230.h:
+spi.h:
+board.h:
+
+include/atusb/atusb.h:
+board_atusb.h:
+mac.h:
+
diff --git a/atusb/fw/sernum.d b/atusb/fw/sernum.d
new file mode 100644
index 0000000..8c04153
--- /dev/null
+++ b/atusb/fw/sernum.d
@@ -0,0 +1,11 @@
+sernum.o: sernum.c usb/usb.h board.h include/atusb/atusb.h board_atusb.h \
+ sernum.h
+
+sernum.c:
+usb/usb.h:
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+
+sernum.h:
+
diff --git a/atusb/fw/spi.d b/atusb/fw/spi.d
new file mode 100644
index 0000000..fa0b3ef
--- /dev/null
+++ b/atusb/fw/spi.d
@@ -0,0 +1,8 @@
+spi.o: spi.c board.h include/atusb/atusb.h board_atusb.h spi.h
+
+spi.c:
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+spi.h:
+
diff --git a/atusb/fw/usb.d b/atusb/fw/usb.d
new file mode 100644
index 0000000..e420d8e
--- /dev/null
+++ b/atusb/fw/usb.d
@@ -0,0 +1,8 @@
+usb.o: usb/usb.c usb/usb.h board.h include/atusb/atusb.h board_atusb.h
+
+usb/usb.c:
+usb/usb.h:
+board.h:
+include/atusb/atusb.h:
+board_atusb.h:
+
diff --git a/atusb/fw/version.c b/atusb/fw/version.c
new file mode 100644
index 0000000..f58413c
--- /dev/null
+++ b/atusb/fw/version.c
@@ -0,0 +1,4 @@
+/* MACHINE-GENERATED. DO NOT EDIT ! */
+#include "version.h"
+const char *build_date =3D "lun. 05 sept. 2022 05:10:00 CEST";
+const uint16_t build_number =3D 26;
diff --git a/atusb/fw/version.d b/atusb/fw/version.d
new file mode 100644
index 0000000..aafbf8c
--- /dev/null
+++ b/atusb/fw/version.d
@@ -0,0 +1,5 @@
+version.o: version.c version.h
+
+version.c:
+version.h:
+
--=20
2.34.1

