Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:51039 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeI1Ue3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Sep 2018 16:34:29 -0400
Subject: Re: [PATCH 2/2] ieee802154: mcr20a: Remove struct
 mcr20a_platform_data
References: <20180831214642.30711-1-liuxuenetmail@gmail.com>
 <20180831214642.30711-3-liuxuenetmail@gmail.com>
 <4447668c-ebf8-186c-709e-cda2b41d1e65@datenfreihafen.org>
 <CAJuUDwv5ecENmWoOmUZLtcVXw6rzGr+e+2tKS0tnqM2cZTa-uQ@mail.gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <fe609339-697e-96dc-c635-70b448f11a4d@datenfreihafen.org>
Date: Fri, 28 Sep 2018 16:10:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAJuUDwv5ecENmWoOmUZLtcVXw6rzGr+e+2tKS0tnqM2cZTa-uQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, "alex. aring" <alex.aring@gmail.com>

Hello Xue.

On 27/09/2018 20:38, Xue Liu wrote:
> Hi Stefan,
> On Thu, 27 Sep 2018 at 17:44, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>>
>> Hello Xue.
>>
>> On 31/08/2018 23:46, Xue Liu wrote:
>>> The struct mcr20a_platform_data is uesed only in probe function
>>> and it holds only one member. So it is not necessary to reserve it.
>>>
>>> Using gpiod family API to handle reset pin.
>>>
>>> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
>>> ---
>>>  drivers/net/ieee802154/mcr20a.c | 64 +++++++--------------------------
>>>  1 file changed, 13 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
>>> index 04891429a554..44de81e5f140 100644
>>> --- a/drivers/net/ieee802154/mcr20a.c
>>> +++ b/drivers/net/ieee802154/mcr20a.c
>>> @@ -132,11 +132,6 @@ static const struct reg_sequence mar20a_iar_overwrites[] = {
>>>  };
>>>
>>>  #define MCR20A_VALID_CHANNELS (0x07FFF800)
>>> -
>>> -struct mcr20a_platform_data {
>>> -     int rst_gpio;
>>> -};
>>> -
>>>  #define MCR20A_MAX_BUF               (127)
>>>
>>>  #define printdev(X) (&X->spi->dev)
>>> @@ -412,7 +407,6 @@ struct mcr20a_local {
>>>       struct spi_device *spi;
>>>
>>>       struct ieee802154_hw *hw;
>>> -     struct mcr20a_platform_data *pdata;
>>>       struct regmap *regmap_dar;
>>>       struct regmap *regmap_iar;
>>>
>>> @@ -976,20 +970,6 @@ static irqreturn_t mcr20a_irq_isr(int irq, void *data)
>>>       return IRQ_HANDLED;
>>>  }
>>>
>>> -static int mcr20a_get_platform_data(struct spi_device *spi,
>>> -                                 struct mcr20a_platform_data *pdata)
>>> -{
>>> -     int ret = 0;
>>> -
>>> -     if (!spi->dev.of_node)
>>> -             return -EINVAL;
>>> -
>>> -     pdata->rst_gpio = of_get_named_gpio(spi->dev.of_node, "rst_b-gpio", 0);
>>> -     dev_dbg(&spi->dev, "rst_b-gpio: %d\n", pdata->rst_gpio);
>>> -
>>> -     return ret;
>>> -}
>>> -
>>>  static void mcr20a_hw_setup(struct mcr20a_local *lp)
>>>  {
>>>       u8 i;
>>> @@ -1249,7 +1229,7 @@ mcr20a_probe(struct spi_device *spi)
>>>  {
>>>       struct ieee802154_hw *hw;
>>>       struct mcr20a_local *lp;
>>> -     struct mcr20a_platform_data *pdata;
>>> +     struct gpio_desc *rst_b;
>>>       int irq_type;
>>>       int ret = -ENOMEM;
>>>
>>> @@ -1260,48 +1240,32 @@ mcr20a_probe(struct spi_device *spi)
>>>               return -EINVAL;
>>>       }
>>>
>>> -     pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
>>> -     if (!pdata)
>>> -             return -ENOMEM;
>>> -
>>> -     /* set mcr20a platform data */
>>> -     ret = mcr20a_get_platform_data(spi, pdata);
>>> -     if (ret < 0) {
>>> -             dev_crit(&spi->dev, "mcr20a_get_platform_data failed.\n");
>>> -             goto free_pdata;
>>> -     }
>>> -
>>> -     /* init reset gpio */
>>> -     if (gpio_is_valid(pdata->rst_gpio)) {
>>> -             ret = devm_gpio_request_one(&spi->dev, pdata->rst_gpio,
>>> -                                         GPIOF_OUT_INIT_HIGH, "reset");
>>> -             if (ret)
>>> -                     goto free_pdata;
>>> +     rst_b = devm_gpiod_get(&spi->dev, "rst_b", GPIOD_OUT_HIGH);
>>
>> I am a bit confused about the pin name here. When using
>> of_get_named_gpio() the name is "rst_b-gpio" which is the same I see
>> referenced in the devicetree bindings file.
>>
>> When switching to devm_gpiod_get() the name is shortened to "rst_b".
>> Does the gpiod API implicitly add a -gpio to the name when searching for
>> it in the dst?
>>
> Yes. The function calling tree is shown below:
> --> devm_gpiod_get()
>     --> __gpiod_get_index()
>          --> of_find_gpio()
> The definition of function of_find_gpio() is here
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib-of.c#L231.
> The definition of struct gpio_suffixes is here
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.h#L95.
> You can see that the suffix "gpio" or "gpios" is automatically added
> when it is looking for the name of gpio in the device tree.

Thanks for the explanation. The missing gpio made me wondering but this
cleared it up.

>> The reason I ask is that I would want to avoid a name change of the
>> property. That would break the dts bindings already in place.
>>
> We don't need to change the dts bindings.

Perfect, that is what I wanted to be sure about. :-)

>>> +     if (IS_ERR(rst_b)) {
>>> +             ret = PTR_ERR(rst_b);
>>> +             if (ret != -EPROBE_DEFER)
>>> +                     dev_err(&spi->dev, "Failed to get 'rst_b' gpio: %d", ret);
>>> +             return ret;
>>>       }
>>>
>>>       /* reset mcr20a */
>>> -     if (gpio_is_valid(pdata->rst_gpio)) {
>>> -             usleep_range(10, 20);
>>> -             gpio_set_value_cansleep(pdata->rst_gpio, 0);
>>> -             usleep_range(10, 20);
>>> -             gpio_set_value_cansleep(pdata->rst_gpio, 1);
>>> -             usleep_range(120, 240);
>>> -     }
>>> +     usleep_range(10, 20);
>>> +     gpiod_set_value_cansleep(rst_b, 1);
>>> +     usleep_range(10, 20);
>>> +     gpiod_set_value_cansleep(rst_b, 0);
>>> +     usleep_range(120, 240);
>>
>> With your change you reversing the setting from ->0->1 to ->1->0. Is the
>> gpiod API reverse here or did you made a copy and paste mistake? :-)
>>
> I am afraid both of assumptions are wrong here. The new GPIO
> descriptor consumer interface uses *logical* value.
> It means 0 and 1 denote GPIO deassertion and assertion. The property
> of rst_b is GPIO_ACTIVE_LOW. So the value 1
> means low in physical line and the value 0 means high.

Interesting. I got myself fooled with the very similar function names
they should work the same. Blame on me for not checking.

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
