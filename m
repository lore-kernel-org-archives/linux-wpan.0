Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34228 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbbCRLlG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 07:41:06 -0400
Received: by wibg7 with SMTP id g7so62396942wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 04:41:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] nl802154: implement new SET commands
Date: Wed, 18 Mar 2015 12:40:20 +0100
Message-Id: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch-series implement the already existed SET commands of an interface
and a wpan-phy. Currently we have one CMD for each setting which was a mistake
by me to implement it in this way. So we aren't currently a "real" UAPI header
for nl802154 and it's still under development. I decide now to change to
implement these setting in this way now. Currently I let these commands in
coexistens with the old commands but _NOTE_ I will remove the other commands
from the nl802154 later.

So please use the new commands. When these patches are mainline I also want to
release a new wpan-tools release which use this new interface. Then everybody
has some time to change to the new wpan-tools release. After this "time" I will
remove the obsolete nl802154 commands from the header. This means older
wpan-tools releases doesn't work any more with new kernels. Also this means
newer wpan-tools releases doesn't work with older kernels. That will end in
some kind of chaos and I will note this on the website.

This beahviour to do it in only one command is much easier to handle in
userspace, like clicking an "apply button".

- Alex

Alexander Aring (2):
  nl802154: add set wpan phy cmd
  nl802154: add set interface cmd

 net/ieee802154/nl802154.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

-- 
2.3.3

