Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDFECAAD3
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 20:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIEUnX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEUnW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 16:43:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1E26565E
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 13:43:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 13F801BF206;
        Mon,  5 Sep 2022 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662410600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uAeRvYt5NYKv1ka0MwEzsEd6cjJhQIlrU3flT5h26cw=;
        b=Sys044HJiDObS8O6fPZL96NMwVQhdVlKdcoelfxfxQPfX0YDSFIwBVcD6GaSJb1hOkYSKN
        dXLTRcLYsC29kr4WDoKv+w3esvFIsAFCY4xaGLm+rD0dQFE2Be1geWGlfclkKnGwBcf1ko
        HVc1gXnAYrnr0a8ZdcjRd1oPbIZq559Y6xhsFo6GfjyKUQlQSHFDB5atVLBMu4G9leIClY
        bjewrTHGCGtuQuvse+PClqJIgdUbd57dICzgKE09Rv1dCcNhkUdv3HvuIk/UaRhBV5zCbb
        0BeI623YeAYmQ44IXmQ95Titz4+1bEovTHFNPUkfTzgU3vEVNGTgp8znVsUHEg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     werner@almesberger.net
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH atusb/fw 1/2] atusb: fw: Update toolchain instructions
Date:   Mon,  5 Sep 2022 22:43:17 +0200
Message-Id: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Those instructions do not work anymore for several reaons:
- Two out of the three files to download return a 404 error:
      * The binutils version does not exist, it was 2.21.1 or 2.21.1a
        instead of just 2.21.
      * The avr-libc is no longer hosted on the pointed website, I've
        found an alternate.
- The binutils version mentioned is not able to compile the firmware on
  a recent distribution, the Internet advised to update its version and
  it worked.
- Most of these compilations will throw warnings if you use a recent
  gcc. Sometimes -Werror is set and it fails the build. To avoid that,
  just use --disable-werror in the ./configure options.
- I had issues building the gcc doc but those issues are trivial to
  fix inline.

Update the instructions for building the toolchain and while at it,
start the file by mentioning that this is maybe not useful anymore, and
provide the packets to install.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 atusb/fw/README | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/atusb/fw/README b/atusb/fw/README
index 99ceb22..44f65f5 100644
--- a/atusb/fw/README
+++ b/atusb/fw/README
@@ -1,4 +1,6 @@
-Requires a very recent toolchain, because ATmega32U2 is relatively new.
+- Toolchain:
+
+  apt install avr-gcc libc-avr
 
 - Building:
 
@@ -64,12 +66,13 @@ apt-get install libmpfr-dev libmpc-dev
 
 # binutils
 
-wget http://ftp.gnu.org/gnu/binutils/binutils-2.21.tar.bz2
-tar xfj binutils-2.21.tar.bz2 
-cd binutils-2.21
-./configure --target=avr --disable-nls
+wget https://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.bz2
+tar xfj binutils-2.27.tar.bz2
+cd binutils-2.27
+./configure --target=avr --disable-nls --disable-werror
 make
 make install
+ln -s /usr/local/bin/avr-as /usr/bin/avr-as
 
 # gcc
 
@@ -85,9 +88,8 @@ cd obj-avr
 make
 make install
 
-wget http://download.savannah.gnu.org/releases/avr-libc/avr-libc-1.7.1.tar.bz2
-tar xfj avr-libc-1.7.1.tar.bz2 
-cd avr-libc-1.7.1
+wget https://android.googlesource.com/toolchain/avr-libc/+archive/master/avr-libc-1.7.1.tar.gz
+tar xf avr-libc-1.7.1.tar.gz
 ./bootstrap	# the automake at the end takes a while
 ./configure --build=`./config.guess` --host=avr
 make
-- 
2.34.1

