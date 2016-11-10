Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45167
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752760AbcKJJBK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Nov 2016 04:01:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 47004A0E74
        for <linux-wpan@vger.kernel.org>; Thu, 10 Nov 2016 09:01:19 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SQR6cV9oED5z for <linux-wpan@vger.kernel.org>;
        Thu, 10 Nov 2016 09:01:18 +0000 (UTC)
Received: from [192.168.2.110] (unknown [217.247.143.154])
        by osg.samsung.com (Postfix) with ESMTPSA id 6667CA0BA4
        for <linux-wpan@vger.kernel.org>; Thu, 10 Nov 2016 09:01:18 +0000 (UTC)
Subject: Re: [ISSUE] Lack of support to set wpan-ping interval
References: <576133E7D398244EA0325FF7CE2A09E5CD56CC3D@G08CNEXMBPEKD02.g08.fujitsu.local>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <4ebf6487-b2b8-db67-346e-02dbcb49b1bc@osg.samsung.com>
Date: Thu, 10 Nov 2016 10:00:52 +0100
MIME-Version: 1.0
In-Reply-To: <576133E7D398244EA0325FF7CE2A09E5CD56CC3D@G08CNEXMBPEKD02.g08.fujitsu.local>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

On 10/11/16 09:56, Xue, Wenqian wrote:
> Hi,
>
> I'm using the wpan-ping function for at86rf233 on RPis for my experiments. I find that current wpan-ping cannot set the interval value like ping (with -i to set the interval).

That is correct. So far I simply had no use case for it. :)

> I added some codes to make wpan-ping support the interval setting. If you consider this as a patch for wpan-ping.c, I could submit it for discussing.

Sure, go ahead and send a patch here.

regards
Stefan Schmidt
