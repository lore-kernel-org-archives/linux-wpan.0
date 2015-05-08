Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56070 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEHJAN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 05:00:13 -0400
Message-ID: <554C7B1A.602@xsilon.com>
Date: Fri, 08 May 2015 10:00:10 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: [PATCHv2 bluetooth-next] mac802154: fakelb: Fix potential NULL pointer
 dereference.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Alex,
Forgot to mention v2 patch corrects a typo in the subject. s/deference/dereference

-Martin.

