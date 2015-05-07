Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:37507 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbbEGQtp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 7 May 2015 12:49:45 -0400
Received: from [10.30.2.205] (account m.petracca@sssup.it [10.30.2.205] verified)
  by sssup.it (CommuniGate Pro SMTP 5.3.15)
  with ESMTPSA id 101563530 for linux-wpan@vger.kernel.org; Thu, 07 May 2015 18:49:44 +0200
Message-ID: <554B97A8.2040802@sssup.it>
Date: Thu, 07 May 2015 18:49:44 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Error in including IEEE802154.h
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear all,
I gave a program in kernel 3.8.17 in which I successfully include
ieee802154.h by simply witing:

#include <ieee802154.h>

In my BeagleBone now I have just upgraded the kernel to 4.0.1,
and compiling the same code I get:

fatal error: ieee802154.h: No such file or directory

Any hint?

Best,
Matteo

