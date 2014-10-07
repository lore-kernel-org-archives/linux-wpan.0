Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34895 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbaJGH4p (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 03:56:45 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so4691812pdj.13
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 00:56:44 -0700 (PDT)
Message-ID: <54339C22.7000601@gmail.com>
Date: Tue, 07 Oct 2014 13:24:10 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-next] 6lowpan: cleanup for lowpan_rcv
References: <1412654055-15368-1-git-send-email-varkabhadram@gmail.com> <20141007074240.GB2768@omega>
In-Reply-To: <20141007074240.GB2768@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Alex,

On 10/07/2014 01:12 PM, Alexander Aring wrote:
> Hi Varka,
>
> On Tue, Oct 07, 2014 at 09:24:15AM +0530, varkabhadram@gmail.com wrote:
>> From: Varka Bhadram <varkab@cdac.in>
>>
>> Instead of collecting the return value into 'ret' variable and
>> checking the perticular return value specifically, this patch
>> remove these by directly including function within 'if' statement
>>
> My opinion to this patch hasn't changed. The return value handling of
> these functions are current broken and Martin works on this. After Martin
> get his patches in you can do some cleanup here.

Ok. Thanks...

-- 
Regards,
Varka Bhadram.

