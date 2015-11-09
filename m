Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46894 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbbKIVLs (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 9 Nov 2015 16:11:48 -0500
Subject: Re: [PATCH wpan-tools] build: avoid redefinition errors with libnl >=
 3.2.27
References: <1447092642-17115-1-git-send-email-stefan@osg.samsung.com>
 <20151109201821.GA608@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56410C0F.7030300@osg.samsung.com>
Date: Mon, 9 Nov 2015 22:11:43 +0100
MIME-Version: 1.0
In-Reply-To: <20151109201821.GA608@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 09/11/15 21:19, Alexander Aring wrote:
> Hi,
>
> On Mon, Nov 09, 2015 at 07:10:42PM +0100, Stefan Schmidt wrote:
>>  From 3.2.17 onwards we have nla for s8, s16, etc defined directly in libnl.
>> If we keep including this file anyway we run into redefinition errors. Better
>> include use our own only for earlier versions.
>>
>> Happened to me on Fedora 22 after my last update.
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> Acked-by: Alexander Aring <alex.aring@gmail.com>

Thanks. Pushed.

> I wonder how could that be when I do #ifndef on each declaration. So I
> was in the hope to avoid such issues....
>

Longer term we should just bump our dependency to 3.2.27 and remove our 
own defines here. I just avoided that for now as the release is to new 
and we should wait for distros to adopt it first. Maybe in 6 months from 
now we can do that.

regards
Stefan Schmidt
