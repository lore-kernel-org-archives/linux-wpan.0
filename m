Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59244 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbbFEVsY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 5 Jun 2015 17:48:24 -0400
Message-ID: <55721924.2080705@osg.samsung.com>
Date: Fri, 05 Jun 2015 23:48:20 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-tools 2/3] gitignore: add generated iwpan-info
References: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com> <1433511132-15818-3-git-send-email-stefan@osg.samsung.com> <20150605160835.GA5850@bogon.m.sigxcpu.org>
In-Reply-To: <20150605160835.GA5850@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?windows-1252?Q?Guido_G=FCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hello.

On 05/06/15 18:08, Guido Günther wrote:
> On Fri, Jun 05, 2015 at 03:32:11PM +0200, Stefan Schmidt wrote:
>> From: Stefan Schmidt <s.schmidt@samsung.com>
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>   src/.gitignore | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/src/.gitignore b/src/.gitignore
>> index d0989d6..356ac21 100644
>> --- a/src/.gitignore
>> +++ b/src/.gitignore
>> @@ -1,5 +1,6 @@
>>   .deps
>>   iwpan
>> +iwpan-info.o
>>   iwpan-interface.o
>>   iwpan-iwpan.o
>>   iwpan-sections.o
> What about using a
>
> *.o
>
> wildcard? Everythng else seems cumbersome in the long run.
> Cheers,

Good point. Updated patch send. Thanks for the review!

regards
Stefan Schmidt
