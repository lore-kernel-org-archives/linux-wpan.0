Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:41497
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755283AbcKVH5N (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 22 Nov 2016 02:57:13 -0500
Subject: Re: [PATCH wpan-tools v3] Add the support to set wpan-ping interval
References: <1479780954-3827-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <e9d80b0a-2739-a02a-565d-68695cb59be1@osg.samsung.com>
Date: Tue, 22 Nov 2016 08:57:05 +0100
MIME-Version: 1.0
In-Reply-To: <1479780954-3827-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: wsn.iot.xwq@cn.fujitsu.com, linux-wpan@vger.kernel.org

Hello.

On 22/11/16 03:15, wsn.iot.xwq@cn.fujitsu.com wrote:
> From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
>
> This patch adds the support to set wpan-ping interval, you can use the command `-I $interval(ms)` to set the value (default 500ms).
>
> Signed-off-by: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
> ---
> The name problem has been fixed (sorry for my misunderstanding). Also the mentioned curly brace has been changed.

Thanks a lot. Patch applied.

I did a tiny tweak at the commit message which was not worth a re-spin 
on your side. Added a wpan-ping prefix in the summary line and break 
line before 80 characters.

https://github.com/linux-wpan/wpan-tools/commit/36fab2b74d2f63f8020cfc5b74851c3ebfbf507e

Thanks for your contribution! :)

regards
Stefan Schmidt
