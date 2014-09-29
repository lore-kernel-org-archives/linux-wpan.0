Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53915 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbaI2Ndb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 09:33:31 -0400
Message-ID: <54295FA9.8030506@xsilon.com>
Date: Mon, 29 Sep 2014 14:33:29 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <20140926153521.GA7643@omega> <542593AC.4060901@xsilon.com> <20140927014243.GA26666@omega> <54293279.5090103@xsilon.com> <54293B6C.7040800@gmail.com> <54293DD4.1090907@xsilon.com> <5429441C.5000302@gmail.com> <5429466F.4080506@gmail.com> <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega>
In-Reply-To: <20140929133048.GB14608@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Yes. It seems to be part of the ipv6 std that you can't disable redirects.
http://www.gossamer-threads.com/lists/nsp/ipv6/20760

On 29/09/14 14:30, Alexander Aring wrote:
> On Mon, Sep 29, 2014 at 03:12:00PM +0200, Alexander Aring wrote:
>> On Mon, Sep 29, 2014 at 01:49:26PM +0100, Simon Vincent wrote:
>> ...
>>>>> Try this . I hope it will work.
>>>> Sorry for the wrong info...
>>>>
>>>> Set up accept_redirects/send_redirects to boolean value '0'
>>>>
>>>> echo 0 > /proc/sys/net/ipv6/conf/all/accept_redirects
>>>> -- 
>>> I don't have a
>>>
>>> /proc/sys/net/ipv6/conf/all/send_redirects
>>>
>>> It looks like it is not possible to disable redirects on ipv6.
>> Do you have SYSFS enabled?
>>
> Sorry I don't mean SYSFS here, something with SYS.... I mean this [0].
>
> The CONFIG_SYSCTL.
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/ipv6/route.c#L2880

