Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50470
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751873AbdITTOR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Sep 2017 15:14:17 -0400
Subject: Re: pull-request: ieee802154 2017-09-20
References: <20170920123008.GA876@work.Speedport_W_724V_09011603_05_010>
 <A8275381-2BDA-4F96-B8BD-E50F16554D23@holtmann.org>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <3f7f1811-9047-42b4-dee8-4888d0797f56@osg.samsung.com>
Date: Wed, 20 Sep 2017 21:14:13 +0200
MIME-Version: 1.0
In-Reply-To: <A8275381-2BDA-4F96-B8BD-E50F16554D23@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hello.

On 09/20/2017 07:08 PM, Marcel Holtmann wrote:
> Hi Stefan,
> 
>> Here comes a pull request for ieee802154 changes I have queued up for
>> this merge window.
>>
>> Normally these have been coming through the bluetooth tree but as this
>> three have been falling through the cracks so far and I have to review
>> and ack all of them anyway I think it makes sense if I save the
>> bluetooth people some work and handle them directly.
>>
>> Its the first pull request I send to you so please let me know if I did
>> something wrong or if you prefer a different format.
> 
> that is fine with me since I think the major contention points are gone these days. I think for 6lowpan patches we might still want them go through bluetooth-next so that they are synced properly.

Fair enough. Having 6lowpan reviewed by both subsystems and patches going through bluetooth-next works well for me.

So I will simply review and pickup ieee802154 related patches from now on and send Dave pull requests for them. (Not a very active subsystem
anyway :))

regards
Stefan Schmidt
