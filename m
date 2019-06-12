Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f172.google.com ([209.85.166.172]:54723 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfFLRUe (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jun 2019 13:20:34 -0400
Received: by mail-it1-f172.google.com with SMTP id m138so12083125ita.4
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jun 2019 10:20:34 -0700 (PDT)
Date: Wed, 12 Jun 2019 13:20:28 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Simulating 6lowpan with mac802154_hwsim
Message-ID: <20190612172028.2fxq6jsj5jsq5pca@x220t>
References: <CAK8U23aVH+O+4OWQrkG-Q+Kf2sD7DhvpDpO8+3C94Y9bE5k8ww@mail.gmail.com>
 <20190612141016.owy6csdatcugsgak@x220t>
 <CAK8U23ZW+4MXkTcmzR9VV=Kw__wfEoXqvphEbH7ZPSe7rGH2Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8U23ZW+4MXkTcmzR9VV=Kw__wfEoXqvphEbH7ZPSe7rGH2Gw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Jun 12, 2019 at 02:07:26PM -0300, Ramon Fontes wrote:
> One node (e.g. node1) can be connected simultaneously to multiple
> nodes  (e.g. node2 and node3) by using only one 6lowpan interface.
> That said, which node (2 or 3) will node1 taking into account? They
> can have different distances and only one interface in which we can
> use TC. Please correct me if I'm wrong. In my mind, the same is true
> for LQI.
> 

For TC it's true, then you need to match on different addresses e.g. mac
address/short address?

For LQI this is not true, because in mac802154_hwsim you say edges as a
set of vectors (which node can reach the other node) and specify the LQI
value which the receiving node will be get.

The main difference here is that TC works on interface layer whereas
mac802154_hwsim can work on phy layer. Maybe TC can even extended for
such purpose?

> This code (https://github.com/ramonfontes/mininet-iot/blob/master/examples/6LoWPan.py)
> produce such scenario. You can also try 6lowpan.py -m for mobility
> purposes.
> 

Need to test it when I have time.

- Alex
