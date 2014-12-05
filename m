Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34400 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaLEMqJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 07:46:09 -0500
Date: Fri, 5 Dec 2014 13:46:05 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: 6lowpan next header compression framwork: module handling or not?
Message-ID: <20141205124602.GB478@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org, martin.townsend@xsilon.com

Hi,

last patch series Jukka, told me to make default "loading" of some next
header compression formats. I agree with that, so users don't need to
extra loading some next header compression modules.

Per default we support some compression formats, that sounds good.


Before that Marcel told (I think if I understand it right) that he wants
to have each nhc compression as separate module and users can do some
modalias magic for autoloading.

Currently I see no option to add support for both of them.

If I do Jukka's default "loading" (not loading of module) I add nhc
and all compression layers into the 6lowpan.ko module. While module_init
of 6lowpan.ko we add all default nhc's. On module_exit we remove _all_
registered nhc.

Marcel idea with modules we have in each nhc compression format a module_init
and a module_exit function. In these functions the nhc compression format will
be added to the nhc framework and removed. With this solution I can't
implement some "load all defaults nhc modules, while loading 6lowpan.ko
module. Users need to do some configuration to make this default
available at startup.


What should I do now?

- Alex
