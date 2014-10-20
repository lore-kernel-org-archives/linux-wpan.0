Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52478 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaJTL47 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 07:56:59 -0400
Message-ID: <5444F889.5010600@xsilon.com>
Date: Mon, 20 Oct 2014 12:56:57 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: multicast problems
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Has anyone had any luck using Site-Local or Realm-Local multicast over 
14.5/6lowpan?

I find if I subscribe to a multicast group using a site-local or 
realm-local scope I can't ping the multicast group. If I try the same on 
a ethernet interface I can ping the multicast group no problems.

Simon
