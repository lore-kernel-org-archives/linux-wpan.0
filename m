Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:55544 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeBEKoT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 5 Feb 2018 05:44:19 -0500
Subject: Re: wpan-tools 0.8 release
References: <dea4d0e2-af43-1d46-2abe-ef947fa1298e@osg.samsung.com>
 <20180205093325.GA6609@bogon.m.sigxcpu.org>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <eb51adc8-91d5-6443-d1b8-7a5d0e2c684c@osg.samsung.com>
Date: Mon, 5 Feb 2018 11:44:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180205093325.GA6609@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.


On 02/05/2018 10:33 AM, Guido Günther wrote:
> Hi,
> On Thu, Feb 01, 2018 at 11:29:11AM +0100, Stefan Schmidt wrote:
>> Hello.
>>
>>
>> It is a pleasure to announce the 0.8 release of wpan-tools.
>> Thanks to everyone who contributed!
>>
>> More of a maintenance release this time around. We did not have a release in a while and the build error with libnl >= 3.3 started to hit
>> more people. Having this fixed is worth a release alone. Thanks a lot to Thomas Petazzoni for the fix.
>>
>> We also added some some examples on how to use the ieee802154 subsystem socket types from userspace.
>> Xue Wenqian added some more functionality to the wpan-ping utility. Mayn thanks here as well.
>>
>> https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.gz
>>
>> sha256sum: 0e22cadbc40d4c12d0a66e8175bda12046f03237ce6da23d4fd26fd3ab557d8b
>>
>> https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.xz
>>
>> sha256sum: daacd38fe2f216095664dbf2628151c8f632d3f122d526059a37ba3cc4d3d8af
> The Debian package has been updated as well:
>
>     https://packages.debian.org/sid/wpan-tools

Thanks a lot for the quick update!

regards
Stefan Schmidt
