Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFACCECAAA1
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 08:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbiIFIVO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIFIVN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Sep 2022 04:21:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736A6F55E
        for <linux-wpan@vger.kernel.org>; Tue,  6 Sep 2022 01:21:09 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9A73CFF809;
        Tue,  6 Sep 2022 08:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662452467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Mcfjnj2ZuQB3HNpcRKcW8RcC8PtWVzdy5RmTqUDokc=;
        b=CVi5+bX1tMPP7i6W74jgO0KNp4+3+EYW9zPvYweqCNNlmur1blsP93MjV775vqaqRuSMdU
        t5oKUf/Vxd+thHLq8zfscKdliTQLriWNy5jXSobGiFa0b1pt9wj757GnfQUqjx4xMj/RLu
        XSwASXk7QnOQcm6D98zXCY5dTxoidga3qhncYhK0gCHD7Iom9eGuTILSWeM8JH3LDLZrt8
        IuOVkrkCTvS2JDUA7t/wFworPg0WBc3bKtw/DzIrzyEI3nBE5EZA1EkkmcetyDhLbiQidQ
        r4BC4jFY3TF/eTZYnv+QTav1odYaZYtjfomka5oQSgv/FUrjqlB9FyldgJBEXQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     werner@almesberger.net
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain instructions
Date:   Tue,  6 Sep 2022 10:21:03 +0200
Message-Id: <20220906082104.1338694-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
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

Changes in v2:
* Fix the avr package names.

 atusb/fw/README | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/atusb/fw/README b/atusb/fw/README
index 99ceb22..774dfeb 100644
--- a/atusb/fw/README
+++ b/atusb/fw/README
@@ -1,4 +1,6 @@
-Requires a very recent toolchain, because ATmega32U2 is relatively new.
+- Toolchain:
+
+  apt install gcc-avr avr-libc binutils-avr
 
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

