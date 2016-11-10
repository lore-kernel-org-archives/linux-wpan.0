Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:4674 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754305AbcKJI4Q (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Nov 2016 03:56:16 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 3EDDD4670075
        for <linux-wpan@vger.kernel.org>; Thu, 10 Nov 2016 16:56:05 +0800 (CST)
From: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Subject: [ISSUE] Lack of support to set wpan-ping interval
Date: Thu, 10 Nov 2016 08:56:04 +0000
Message-ID: <576133E7D398244EA0325FF7CE2A09E5CD56CC3D@G08CNEXMBPEKD02.g08.fujitsu.local>
Content-Language: zh-CN
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi, 

I'm using the wpan-ping function for at86rf233 on RPis for my experiments. I find that current wpan-ping cannot set the interval value like ping (with -i to set the interval).
I added some codes to make wpan-ping support the interval setting. If you consider this as a patch for wpan-ping.c, I could submit it for discussing.

Thank you all!

Best Regards,
Xue Wenqian

